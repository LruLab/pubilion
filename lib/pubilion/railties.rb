# frozen_string_literal: true

module Pubilion
  # Railtie for Pubilion.
  #
  # This class is used for loading rake tasks.
  # When this gem is loaded in a Rails application, tasks in +lib/tasks+ are loaded automatically.
  class Railtie < Rails::Railtie
    railtie_name :pubilion

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
