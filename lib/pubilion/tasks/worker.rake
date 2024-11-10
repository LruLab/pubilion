# frozen_string_literal: true

namespace :pubilion do
  namespace :worker do
    desc "Start the Pubilion worker"
    task start: :environment do
      Pubilion::Worker.run
    end
  end
end
