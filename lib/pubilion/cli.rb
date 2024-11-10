# frozen_string_literal: true

require "thor"
require "pubilion/cli/topic"
require "pubilion/cli/subscription"

module Pubilion
  # Command Line Interface for Pubilion
  class CLI < Thor
    desc "subscription SUBCOMMAND ...ARGS", "Manage subscriptions"
    subcommand "subscription", Pubilion::CLI::Subscription

    desc "topic SUBCOMMAND ...ARGS", "Manage topics"
    subcommand "topic", Pubilion::CLI::Topic

    desc "version", "Print the version"
    def version
      puts Pubilion::VERSION
    end
  end
end
