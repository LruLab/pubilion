# frozen_string_literal: true

require "thor"

module Pubilion
  class CLI < Thor
    class Subscription < Thor
      desc "create TOPIC_NAME SUBSCRIPTION_NAME", "Create a new subscription"
      option :topic, required: true, desc: "The topic name"
      def create(subscription_name)
        topic = client.find_topic(options[:topic])
        subscription = topic.subscribe(subscription_name)
        puts "Subscription #{subscription.name} created."
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
