# frozen_string_literal: true

module Pubilion
  class Worker
    class Runner
      WAIT_INTERVAL = 1
      EXIT_SIGNALS = %w[SIGTERM SIGINT].freeze

      attr_reader :subscriber

      def initialize(config)
        @handler = Pubilion::Worker::MessageHandler.new
        @subscriber = Pubilion::Worker::Subscriber.new(config, @handler)
      end

      def run
        subscriber.run

        wait_for_exits
      ensure
        subscriber.shutdown
      end

      def wait_for_exits(signals = EXIT_SIGNALS)
        exit_requested = false
        signals.each { |sig| Signal.trap(sig) { exit_requested = true } }

        sleep WAIT_INTERVAL until exit_requested || subscriber.stopped?
      end
    end
  end
end
