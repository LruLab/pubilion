# frozen_string_literal: true

RSpec.describe Pubilion::Config do
  describe ".configure" do
    it "yields self" do
      expect { |b| described_class.configure(&b) }.to yield_with_args(described_class)
    end
  end

  describe ".project_id" do
    context "when project_id is set" do
      before { described_class.project_id = "project-id" }

      it "returns the project_id" do
        expect(described_class.project_id).to eq("project-id")
      end
    end

    context "when project_id is not set" do
      before { described_class.project_id = nil }

      context "when PUBSUB_PROJECT_ID is not set" do
        before { modify_env("PUBSUB_PROJECT_ID" => nil) }

        it "return nil" do
          expect(described_class.project_id).to eq(nil)
        end
      end

      context "when PUBSUB_PROJECT_ID is set" do
        before { modify_env("PUBSUB_PROJECT_ID" => "dummy-project-id") }

        it "return the PUBSUB_PROJECT_ID" do
          expect(described_class.project_id).to eq("dummy-project-id")
        end
      end
    end
  end

  describe ".credentials" do
    context "when credentials is set" do
      before { described_class.credentials = "/path/to/credentials" }

      it "returns the credentials" do
        expect(described_class.credentials).to eq("/path/to/credentials")
      end
    end

    context "when credentials is not set" do
      before { described_class.credentials = nil }
      context "when GOOGLE_APPLICATION_CREDENTIALS is not set" do
        before { modify_env("GOOGLE_APPLICATION_CREDENTIALS" => nil) }

        it "return nil" do
          expect(described_class.credentials).to eq(nil)
        end
      end

      context "when GOOGLE_APPLICATION_CREDENTIALS is set" do
        before { modify_env("GOOGLE_APPLICATION_CREDENTIALS" => "/path/to/credentials") }

        it "return the GOOGLE_APPLICATION_CREDENTIALS" do
          expect(described_class.credentials).to eq("/path/to/credentials")
        end
      end
    end
  end
end
