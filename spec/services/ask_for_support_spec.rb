require 'spec_helper'

describe AskForSupport do

  subject {  described_class.new(User.new, Topic.new, {}) }
  let(:user){ User.new }

  describe '#commence!' do
    before { subject.stub(supporter: user, deliver_email: true) }

    it "should save new_support" do
      expect(subject.new_support).to receive(:save!)
      subject.commence!
    end

    it "should send email out" do
      allow(subject.new_support).to receive(:save!)
      expect(subject).to receive(:deliver_email)
      subject.commence!
    end

  end

end
