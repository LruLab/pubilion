# frozern_string_literal: true

require "thor"

module Pubilion
  class CLI < Thor
    class Topic < Thor
      desc "create TOPIC_NAME", "Create a new topic"
      def create(topic_name)
        topic = client.create_topic(topic_name)
        puts "Topic #{topic.name} created."
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
