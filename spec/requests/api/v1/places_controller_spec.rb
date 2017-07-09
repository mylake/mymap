require 'rails_helper'

describe Api::V1::PlacesController, type: :request, api: true do
  describe 'POST /api/v1/places' do
    let!(:user) { create(:user) }
    let(:params) {
      {
        name: 'kfc',
        category: 'food',
        desc: 'delicious',
        lat: '123',
        lon: '123'
      }
    }

    context '200' do
      subject! { api_request :post, '/api/v1/places', { place: params }, user }
      it { expect(response).to have_http_status(200) }
      it { expect(JSON.parse(response.body)['name']).to be_present }
      it { expect(user.places.count).to eq(1) }
    end
  end
end
