# frozen_string_literal: true

module Pubilion
  # Configs for Pubilion
  class Config
    class << self
      attr_writer :project_id, :credentials

      def configure
        yield self
      end

      def project_id
        @project_id ||= ENV.fetch("PUBSUB_PROJECT_ID", nil)
      end

      def credentials
        @credentials ||= ENV.fetch("GOOGLE_APPLICATION_CREDENTIALS", nil)
      end
    end
  end
end
