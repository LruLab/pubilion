# frozen_string_literal: true

module EnvHelper
  def modify_env(vars)
    allow(ENV).to receive(:fetch).and_call_original
    vars.each do |key, value|
      allow(ENV).to receive(:fetch).with(key, any_args).and_return(value)
    end
  end
end

RSpec.configure do |config|
  config.include EnvHelper
end
