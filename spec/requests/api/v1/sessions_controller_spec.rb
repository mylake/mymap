require 'rails_helper'

describe Api::V1::SessionsController, type: :request, api: true do
  describe 'POST /api/v1/sessions' do
    let!(:user) { create(:user, email: 'users@gmail.com', password: '12345678') }
    let(:params) {
      {
        email: user.email,
        password: user.password
      }
    }
    context '200' do
      subject! { api_request :post, '/api/v1/sessions', user: params }
      it { expect(response).to have_http_status(200) }
      it { expect(JSON.parse(response.body)['access_token']).to be_present }
    end

    context '401' do
      let(:params) {
        {
          email: 'notfound@gmail.com',
          password: 'password'
        }
      }
      subject! { api_request :post, '/api/v1/sessions', user: params }
      it { expect(response).to have_http_status(401) }
      it { expect(JSON.parse(response.body)['message']).to eq('User not found') }
    end


  end
end
