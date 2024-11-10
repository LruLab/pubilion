# frozen_string_literal: true

require "pubilion/version"
require "pubilion/errors"
require "pubilion/config"

require "pubilion/extensions"

require "pubilion/worker"

require "pubilion/railties" if defined?(Rails::Railtie)

# Pubilion is a Ruby library for interacting with Google Cloud Pub/Sub.
module Pubilion
end
