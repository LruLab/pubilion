# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    # Cloud Pub/Sub Queue Adapter  for ActiveJob
    class PubSubAdapter
      require "google/cloud/pubsub"

      # Enqueue a job to Cloud Pub/Sub.
      # @param job [ActiveJob::Base] the job to enqueue.
      def enqueue(job)
        topic = client.find_topic(job.queue_name)
        raise Pubilion::TopicNotFound, "Topic not found: #{job.queue_name}" if topic.nil?

        topic.publish(job.serialize.to_json)
      end

      # THIS METHOD IS NOT SUPPORTED.
      # Always raise Pubilion::NotSupported.
      # Because PubSub does not support job scheduling.
      # If you need to schedule jobs, use a Cloud Tasks or other QueueAdapter.
      def enqueue_at(_job, _timestamp)
        raise Pubilion::NotSupported, <<~MSG
          PubSub does not support job scheduling.
          If you need to schedule jobs, use a Cloud Tasks or other QueueAdapter.
        MSG
      end

      private

      def client
        @client ||= Google::Cloud::PubSub.new(
          project_id: Pubilion::Config.project_id,
          credentials: Pubilion::Config.credentials
        )
      end
    end
  end
end
