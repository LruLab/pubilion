# frozen_string_literal: true

module Pubilion
  # Custom error classes for Pubilion
  class Error < StandardError; end

  # Raised when a feature is not supported by Pubilion
  class NotSupported < Error; end

  # Raised when a topic is not found in message publishing or subscribing
  class TopicNotFound < Error; end
end
