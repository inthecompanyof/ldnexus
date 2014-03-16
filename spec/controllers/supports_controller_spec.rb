require 'spec_helper'

describe SupportsController do
  context '#skip' do
    let(:support) { double(:support, id: 4) }
    let(:skip_service) { double(:skip_service) }

    before do
      expect(controller).to receive(:current_user).and_return(double(:user))
      expect(Support).to receive(:find).with(support.id.to_s).and_return(support)
    end

    it 'executes SkipSupport service' do
      expect(SkipSupport).to receive(:new).with(support).and_return(skip_service)
      expect(skip_service).to receive(:skip!)

      post :skip, id: support.id
    end

    context 'when there is an error' do
      it 'redirects to support path' do
        expect(SkipSupport).to receive(:new).with(support).and_raise OnlyHopeError
        post :skip, id: support.id
        expect(response).to redirect_to support_path(support)
      end
    end
  end
end

