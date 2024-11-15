# frozen_string_literal: true

module Pubilion
  class Worker
    # Message handler for Pubilion worker
    class MessageHandler
      require "active_support/inflector"

      # Handle incoming message
      def on_message(message)
        autoreload do
          job = deserialize(message.data)

          if job.nil?
            message.nack!
            return
          end

          job.perform_now
          message.ack!
        end
      rescue StandardError
        message.nack!
      end

      # Handle error
      def on_error(error)
        # TODO: Implement error handling
      end

      private

      def deserialize(payload)
        job_data = JSON.parse(payload)
        klass = job_data["job_class"]&.safe_constantize
        return nil if klass.nil?

        instance = klass.new
        instance.deserialize(job_data)

        instance
      end

      def autoreload(&block)
        if defined?(Rails)
          Rails.application.reloader.wrap(&block)
        else
          block.call
        end
      end
    end
  end
end
