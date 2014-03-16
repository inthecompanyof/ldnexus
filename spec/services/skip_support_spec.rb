require_relative '../../app/services/skip_support'

describe SkipSupport do
  let(:candidates) { 2.times.map { double(:user) } }
  let(:support) { double(:support) }

  subject { described_class.new support }

  context 'with availivable candidates' do
    before { allow(subject).to receive(:candidates).and_return(candidates) }

    it 'assigns and save new user to support' do
      expect(support).to receive :user=
      expect(support).to receive :save!
      subject.skip!
    end
  end
  context 'with no availivable candidates' do
    before { allow(subject).to receive(:candidates).and_return([]) }

    it 'fails with exception' do
      expect { subject.skip!}.to raise_error(OnlyHopeError)
    end
  end
end

