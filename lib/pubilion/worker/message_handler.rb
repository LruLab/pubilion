# frozen_string_literal: true

module Pubilion
  class Worker
    class MessageHandler
      require "active_support/inflector"

      def on_message(message)
        job = deserialize(message.data)

        if job.nil?
          message.nack!
          return
        end

        job.perform_now
        message.ack!
      rescue StandardError
        message.nack!
      end

      def on_error(error)
        # TODO: Implement error handling
      end

      def deserialize(payload)
        job_data = JSON.parse(payload)
        klass = job_data["job_class"]&.safe_constantize
        return nil if klass.nil?

        instance = klass.new
        instance.deserialize(job_data)

        instance
      end
    end
  end
end
