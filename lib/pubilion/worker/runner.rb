# frozen_string_literal: true

module Pubilion
  class Worker
    # Runner for Pubilion worker
    class Runner
      WAIT_INTERVAL = 1
      EXIT_SIGNALS = %w[SIGTERM SIGINT].freeze

      attr_reader :subscriber

      def initialize(config)
        @handler = Pubilion::Worker::MessageHandler.new
        @subscriber = Pubilion::Worker::Subscriber.new(config, @handler)
      end

      # Start worker and wait for exits.
      def run
        subscriber.run

        wait_for_exits
      ensure
        subscriber.shutdown
      end

      private

      def wait_for_exits(signals = EXIT_SIGNALS)
        exit_requested = false
        signals.each { |sig| Signal.trap(sig) { exit_requested = true } }

        sleep WAIT_INTERVAL until exit_requested || subscriber.stopped?
      end
    end
  end
end
