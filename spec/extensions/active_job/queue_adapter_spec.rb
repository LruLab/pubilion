# frozen_string_literal: true

RSpec.describe ActiveJob::QueueAdapters::PubSubAdapter do
  describe "#enqueue" do
    subject { described_class.new.enqueue(job) }

    let(:job_klass) do
      Class.new(ActiveJob::Base) do
        def perform(*args)
          # Do nothing
        end
      end
    end
    let(:job) { job_klass.new(args) }
    let(:args) { [1, 2, 3] }

    let(:client) { instance_double(Google::Cloud::PubSub::Project) }
    let(:topic) { instance_double(Google::Cloud::PubSub::Topic) }

    before do
      allow(Google::Cloud::PubSub).to receive(:new).and_return(client)
      allow(client).to receive(:find_topic).and_return(topic)
      allow(topic).to receive(:publish)
    end

    it "enqueues the job" do
      Timecop.freeze do
        subject

        expect(client).to have_received(:find_topic).with(job.queue_name)
        expect(topic).to have_received(:publish).with(job.serialize.to_json)
      end
    end
  end

  describe "#enqueue_at" do
    subject { described_class.new.enqueue_at(double, double) }

    it "is not supported" do
      expect { subject }.to raise_error(Pubilion::NotSupported)
    end
  end
end
