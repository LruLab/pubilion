# frozen_string_literal: true

class TestJob < ApplicationJob
  queue_as :default

  def perform
    puts "TestJob is running"
  end
end
