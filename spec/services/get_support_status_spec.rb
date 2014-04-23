require 'spec_helper'

describe GetSupportStatus do
  let(:support) { Support.new }
  subject { described_class.new support }

  describe 'commence!' do
    context "returns 'new'" do
      it 'when support is from today' do
        expect(support).to receive(:created_at).and_return(10.hours.ago)
        expect(subject.commence!).to eq 'new'
      end
    end

    context "returns 'ok'" do
      it 'when support is from today' do
        expect(support).to receive(:created_at).and_return(25.hours.ago)
        expect(subject.commence!).to eq 'ok'
      end
    end

    context "returns 'worrying'" do
      it 'when support is older than 2 days' do
        expect(support).to receive(:created_at).and_return(2.days.ago)
        expect(subject.commence!).to eq 'worrying'
      end
    end

    context "returns 'critical'" do
      it 'when support is older than 5 days' do
        expect(support).to receive(:created_at).and_return(5.days.ago)
        expect(subject.commence!).to eq 'critical'
      end
    end
  end
end
