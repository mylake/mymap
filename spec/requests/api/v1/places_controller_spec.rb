require 'rails_helper'

describe Api::V1::PlacesController, type: :request, api: true do

  let!(:user) { create(:user) }

  describe 'GET /api/v1/places' do
    context '200' do
      # TODO paginate
      subject! { api_request :get, '/api/v1/places', {}, user }
      it { expect(response).to have_http_status(200) }
    end
  end

  describe 'POST /api/v1/places' do
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
      it { expect(JSON.parse(response.body)['place']['name']).to be_present }
      it { expect(user.places.count).to eq(1) }
    end
  end

  describe 'PATCH /api/v1/places/:id' do
    let!(:place) { create(:place) }
    let(:params) {
      {
        name: 'update_kfc',
        category: 'update_food',
        desc: 'delicious',
        lat: '123',
        lon: '123'
      }
    }
    context '200' do
      subject! { api_request :patch, "/api/v1/places/#{place.id}", { place: params }, user }
      it { expect(response).to have_http_status(200) }
      it { expect(JSON.parse(response.body)['place']['name']).to eq(params[:name]) }
    end
  end

  describe 'DELETE /api/v1/places/:id' do
  end

end
