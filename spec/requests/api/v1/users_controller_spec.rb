require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request, api: true do
  describe 'POST /api/v1/users' do
    let(:params) {
      {
        email: 'users@gmail.com',
        password: 'password'
      }
    }

    context '200' do
      subject! { api_request :post, '/api/v1/users', user: params }
      it { expect(response).to have_http_status(200) }
      it { expect(JSON.parse(response.body)['email']).to be_present }
      it { expect(JSON.parse(response.body)['access_token']).to be_present }
    end

  end
end
