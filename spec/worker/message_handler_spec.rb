# frozen_string_literal: true

RSpec.describe Pubilion::Worker::MessageHandler do
  describe "#on_message" do
    subject { described_class.new.on_message(message) }

    let(:message) { instance_double(Google::Cloud::PubSub::ReceivedMessage) }
    let(:data) { { "job_class" => "TestJob" }.to_json }

    let(:job_klass) do
      Class.new(ActiveJob::Base) do
        def perform(*args)
          # Do nothing
        end
      end
    end
    let(:job_instance) { instance_double(job_klass) }

    before do
      allow(message).to receive(:data).and_return(data)
      allow(message).to receive(:nack!)
      allow(message).to receive(:ack!)
    end

    context "when job exists" do
      before do
        stub_const("TestJob", job_klass)
        allow(job_klass).to receive(:new).and_return(job_instance)
        allow(job_instance).to receive(:deserialize)
      end

      context "when job do not has error" do
        before do
          allow(job_instance).to receive(:perform_now).and_return(true)
        end

        it "performs the job and ack!" do
          subject

          expect(job_instance).to have_received(:perform_now).once
          expect(message).to have_received(:ack!).once
          expect(message).not_to have_received(:nack!)
        end
      end

      context "when job has error" do
        before do
          allow(job_instance).to receive(:perform_now).and_raise(StandardError)
        end

        it "performs the job and nack!" do
          subject

          expect(job_instance).to have_received(:perform_now).once
          expect(message).to have_received(:nack!).once
          expect(message).not_to have_received(:ack!)
        end
      end
    end

    context "when job do not exists" do
      it "nack!" do
        subject

        expect(message).to have_received(:nack!).once
        expect(message).not_to have_received(:ack!)
      end
    end
  end
end
