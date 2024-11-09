# frozen_string_literal: true

require "pubilion/worker/message_handler"
require "pubilion/worker/subscriber"
require "pubilion/worker/runner"

module Pubilion
  class Worker
    class << self
      def run
        Pubilion::Worker::Runner.new(Pubilion::Config).run
      end
    end
  end
end
