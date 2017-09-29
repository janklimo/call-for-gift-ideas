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

  describe 'create' do
    context 'successful creation' do
      it 'renders successful status' do
        params = {
          sender_name: 'Jamie',
          sender_email: 'jamie@lannister.com',
          recipient_name: 'Jon',
          recipient_email: 'jon@snow.com'
        }
        post :create, params: params
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'ok'
      end

      context 'recipient sex is included' do
        it 'renders successful status' do
          params = {
            sender_name: 'Jamie',
            sender_email: 'jamie@lannister.com',
            recipient_name: 'Jon',
            recipient_email: 'jon@snow.com',
            recipient_sex: 'female'
          }
          post :create, params: params
          resp = JSON.parse(response.body)
          expect(resp['status']).to eq 'ok'
          expect(Call.last.recipient_sex).to eq 'female'
        end
      end
    end

    context 'failed creation' do
      it 'renders failed status' do
        params = {
          sender_email: 'jamie@lannister.com',
          recipient_name: 'Jon',
          recipient_email: 'jon@snow.com'
        }
        post :create, params: params
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'failed'
      end
    end
  end
end
