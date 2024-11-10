# frozen_string_literal: true

require "rails/generators/base"

module Pubilion
  module Generators
    # Install generator for Pubilion.
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Copy initializer file to your application."

      def copy_initializer_file
        template "pubilion.rb", "config/initializers/pubilion.rb"
      end
    end
  end
end
