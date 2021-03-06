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
      it 'redirects to root with a flash message' do
        slug = 'MonkeyBananaSomethingYellow'
        get :show, params: { id: slug }
        expect(response).to redirect_to root_url
        expect(flash[:alert]).to eq "We couldn't find that :("
      end
    end

    context 'call is inactive' do
      before { @call = create(:call, status: :completed) }
      it 'redirects to root with a flash message' do
        get :show, params: { id: @call.slug }
        expect(response).to redirect_to root_url
        expect(flash[:notice]).to eq "This call has already been completed 👍"
      end
    end
  end

  describe 'create' do
    context 'successful creation' do
      it 'renders successful status and sends out an email' do
        params = {
          call: {
            sender_name: 'Jamie',
            sender_email: 'jamie@lannister.com',
            recipient_name: 'Jon',
            recipient_email: 'jon@snow.com'
          }
        }
        post :create, params: params
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'ok'
        email = ActionMailer::Base.deliveries.first
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(email.to).to eq ['jon@snow.com']
        expect(email.subject).to eq 'Jon, Pick Your Present 😻'
      end

      context 'recipient sex is included' do
        it 'renders successful status' do
          params = {
            call: {
              sender_name: 'Jamie',
              sender_email: 'jamie@lannister.com',
              recipient_name: 'Jon',
              recipient_email: 'jon@snow.com',
              recipient_sex: 'female'
            }
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
          call: {
            sender_email: 'jamie@lannister.com',
            recipient_name: 'Jon',
            recipient_email: 'jon@snow.com'
          }
        }
        post :create, params: params
        expect(response.status).to eq 422
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end
  end

  describe 'update' do
    before do
      @call = create(:call)
      @products = create_list(:product, 5)
    end

    it 'renders successful status and delivers an email' do
      params = { id: @call.slug, call: { preferences: [@products[3].id, @products[1].id] } }
      put :update, params: params
      resp = JSON.parse(response.body)
      expect(resp['status']).to eq 'ok'

      @call.reload
      expect(@call.preferences).to eq [@products[3].id.to_s, @products[1].id.to_s]
      expect(@call).to be_completed

      # email delivery
      email = ActionMailer::Base.deliveries.first
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(email.to).to eq ['elon@musk.com']
      expect(email.subject).to include "Elon, here's Jon's wishlist!"
    end

    it 'does not allow to un-complete a call' do
      params = { id: @call.slug, call: { preferences: [@products[2].id], status: 'active' } }
      put :update, params: params
      resp = JSON.parse(response.body)
      expect(resp['status']).to eq 'ok'

      @call.reload
      expect(@call.preferences).to eq [@products[2].id.to_s]
      expect(@call).to be_completed
    end

    context 'completed call' do
      before { @call.update(status: :completed, preferences: [1]) }
      it 'does not allow updating' do
        params = { id: @call.slug, call: { preferences: [9] } }
        put :update, params: params

        expect(response).to redirect_to root_url

        @call.reload
        expect(@call.preferences).to eq ['1']
        expect(@call).to be_completed
      end
    end

    context 'demo calls' do
      before { @call.update(demo: true) }
      it 'never get toggled to completed' do
        params = { id: @call.slug, call: { preferences: [42] } }
        put :update, params: params
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'ok'

        @call.reload
        expect(@call).to be_active
        # updating is skipped
        expect(@call.preferences).to be_empty
      end
    end
  end
end
