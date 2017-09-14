require 'rails_helper'

describe CallsController, type: :controller do
  describe 'show' do
    context 'call exists' do
      before { @call = create(:call) }
      it 'shows the call' do
        get :show, params: { id: @call.slug }
        expect(response.response_code).to eq 200
      end
    end

    context 'call does not exist' do
      it 'redirects to root' do
        slug = 'MonkeyBananaSomethingYellow'
        get :show, params: { id: slug }
        expect(response).to redirect_to root_url
      end
    end
  end
end
