require 'spec_helper'
describe FinishSupport do

  let(:user) { User.new }
  let(:support) { Support.new }
  subject { described_class.new user, support }

  describe "commence!" do

    let(:another_user) { User.new }

    before { support.stub(:save!) }

    it "reassigns user support" do
      support.user = another_user
      subject.commence!
      expect(support.user).to eq(subject.user)
    end

    it "finishes support" do
      subject.commence!
      expect(support).to be_done
    end

    it "updates user counter" do
      expect{ subject.commence! }.to change{ user.supports_count }.by(1)
    end

  end

end
