require 'spec_helper'

describe CommentOnSupport do
  subject { described_class.new(User.new, Support.new, {}) }

  describe "#commence!" do
    before { subject.stub(deliver_email: true) }

    it "saves new comment" do
      expect(subject.new_comment).to receive(:save!)
      subject.commence!
    end

    it "sends email to subscribers" do
      allow(subject.new_comment).to receive(:save!)
      expect(subject).to receive(:deliver_email)
      subject.commence!
    end
  end
end
