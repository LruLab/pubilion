# frozen_string_literal: true

require "pubilion/version"
require "pubilion/errors"
require "pubilion/config"

require "pubilion/extensions"
require "pubilion/worker"
require "pubilion/cli"

require "pubilion/railties" if defined?(Rails::Railtie)
require "pubilion/generators/install_generator" if defined?(Rails::Generators)

# Ruby library for performing job with Google Cloud Pub/Sub.
module Pubilion; end
