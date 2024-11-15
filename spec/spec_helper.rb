# frozen_string_literal: true

require "pubilion"
require "active_job"
require "timecop"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Load support files
  support_regex = File.absolute_path(File.join(File.dirname(__FILE__), "support", "**", "*.rb"))
  Dir.glob(support_regex).each do |helper|
    require helper
  end
end
