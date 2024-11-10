# frozen_string_literal: true

module Pubilion
  # Configuration for Pubilion
  class Config
    class << self
      attr_writer :project_id, :credentials, :topic, :subscription

      # Configure Pubilion.
      #
      # @yield [config] Configuration object
      # @example
      #   Pubilion::Config.configure do |config|
      #     config.project_id = "my-project"
      #     config.credentials = "/path/to/credentials.json"
      #     config.topic = "my-topic"
      #     config.subscription = "my-subscription"
      #   end
      # @return [void]
      def configure
        yield self
      end

      # Google Cloud Project ID.
      # If it is not set, it will try to get from environment variable +PUBSUB_PROJECT_ID+.
      # If it still unsettled, implicitly set by Google Cloud SDK.
      #
      # @return [String, nil]
      def project_id
        @project_id ||= ENV.fetch("PUBSUB_PROJECT_ID", nil)
      end

      # Credentials file path for access to Cloud Pub/Sub.
      # If not set, it will try to get from environment variable  +GOOGLE_APPLICATION_CREDENTIALS+.
      # If not set and +GOOGLE_APPLICATION_CREDENTIALS+ is not set, it will implicitly set by Google Cloud SDK.
      #
      # @return [String, nil]
      def credentials
        @credentials ||= ENV.fetch("GOOGLE_APPLICATION_CREDENTIALS", nil)
      end

      # Topic name of subscription.
      # If not set, it will try to get from +PUBSUB_TOPIC+.
      # This configuration is required for +Pubilion::Worker+.
      #
      # @return [String, nil]
      def topic
        @topic ||= ENV.fetch("PUBSUB_TOPIC", nil)
      end

      # Subscription name.
      # If not set, it will try to get from +PUBSUB_SUBSCRIPTION+.
      # This configuration is required for +Pubilion::Worker+.
      #
      # @return [String, nil]
      def subscription
        @subscription ||= ENV.fetch("PUBSUB_SUBSCRIPTION", nil)
      end
    end
  end
end
