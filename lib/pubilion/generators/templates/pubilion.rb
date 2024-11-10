# frozen_string_literal: true

Pubilion::Config.configure do |config|
  # Set Google Cloud Project ID
  # Can be specified by the environment variable `PUBSUB_PROJECT_ID`
  # config.project_id = "your-project-id"

  # Set Google Cloud Pub/Sub topic name to subscribe
  # Can be specified by the environment variable `PUBSUB_TOPIC`
  # config.topic = "your-topic-name"

  # Set Google Cloud Pub/Sub subscription name
  # Can be specified by the environment variable `PUBSUB_SUBSCRIPTION`
  # config.subscription = "your-subscription-name"

  # Set Google Cloud Pub/Sub credentials file path
  # Can be specified by the environment variable `GOOGLE_APPLICATION_CREDENTIALS`
  # config.credentials = "/path/to/credentials.json"
end
