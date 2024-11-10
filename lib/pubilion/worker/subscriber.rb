# frozen_string_literal: true

module Pubilion
  class Worker
    # Subscriber on Pubilion
    class Subscriber
      require "google/cloud/pubsub"

      SHUTDOWN_WAIT = 20

      attr_reader :config, :handler

      def initialize(config, handler)
        @config = config
        @handler = handler
      end

      # Start streaming pull subscribe.
      def run
        @subscriber = subscription.listen do |message|
          handler.on_message(message)
        end

        @subscriber.on_error do |error|
          handler.on_error(error)
        end

        @subscriber.start
      end

      # Stop streaming pull subscribe.
      def shutdown
        @subscriber&.stop&.wait!(SHUTDOWN_WAIT)
      end

      # Check if subscriber is alive.
      def alive?
        @subscriber.started? && !@subscriber.stopped?
      end

      # Check if subscriber is stopped.
      def stopped?
        @subscriber.stopped?
      end

      private

      def client
        @client ||= Google::Cloud::PubSub.new(
          project_id: config.project_id,
          credentials: config.credentials
        )
      end

      def topic
        @topic ||= client.find_topic(config.topic)
        raise Pubilion::TopicNotFound, "Topic not found: #{config.topic}" if @topic.nil?

        @topic
      end

      def subscription
        @subscription ||= topic.find_subscription(config.subscription)
        raise Pubilion::SubscriptionNotFound, "Subscription not found: #{config.subscription}" if @subscription.nil?

        @subscription
      end
    end
  end
end
