require 'spec_helper'

describe Support do
  subject {  described_class.new }

  describe '#discussed?' do
    context 'returns true' do
      after :each do
        expect(subject.discussed?).to be true
      end

      it 'when there are some comments' do
        expect(subject).to receive(:comments_count).and_return(10)
      end

    end
    context 'returns false' do
      after :each do
        expect(subject.discussed?).to be false
      end

      it 'when there are no comments' do
        expect(subject).to receive(:comments_count).and_return(0)
      end
    end
  end
end
