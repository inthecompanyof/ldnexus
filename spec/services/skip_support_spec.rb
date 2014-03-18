require_relative '../../app/services/skip_support'

describe SkipSupport do
  let(:candidates) { 2.times.map { double(:user, present?: true) } }
  let(:support) { double(:support) }
  let(:skip!) { subject.skip! }

  subject { described_class.new support }

  describe '#skip!' do
    context 'with available candidates' do
      before { allow(subject).to receive(:candidates).and_return(candidates) }

      it 'assigns and save new user to support' do
        expect(support).to receive :user=
        expect(support).to receive :save!
        skip!
      end
    end
  end

  describe '#success?' do
    it 'is true when there are some candidates available' do
      allow(support).to receive :user=
      allow(support).to receive :save!

      subject.candidates = [double(:candidate)]

      skip!

      expect(subject.success?).to be true
    end

    it 'is false when there is no candidate available' do
      subject.candidates = []
      skip!

      expect(subject.success?).to be false
    end
  end
end

