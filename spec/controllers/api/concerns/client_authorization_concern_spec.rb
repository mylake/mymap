require 'rails_helper'

class FoosController < ActionController::Base; end

RSpec.describe Api::ClientAuthorizationConcern, type: :controller, api: true do

  controller(FoosController) do
    include Api::ClientAuthorizationConcern

    def index
      render json: { ok: true }
    end
  end

  before {
    routes.draw {
      get 'index' => 'foos#index'
    }
  }

  context 'with exact ts and cs' do
    let(:ts) { Time.now.to_i }
    let(:cs) { generate_checksum(ts) }
    let(:headers) do
      {
        'X-CS' => cs,
        'X-TS' => ts
      }
    end

    before { @request.env.merge!(headers) }
    subject! { get :index }

    it { expect(response).to be_success }

    context 'with expired ts' do
      let(:ts) { 1.hour.ago.to_i }
      it { expect(response.status).to eq(401) }
    end

    context 'with wrong cs' do
      let(:cs) { '123123123' }
      it { expect(response.status).to eq(401) }
    end

    context 'with wrong ts' do
      let(:ts) { 'abc' }
      it { expect(response.status).to eq(401) }
    end

    context 'without ts' do
      let(:ts) { nil }
      it { expect(response.status).to eq(400) }
    end

    context 'without cs' do
      let(:cs) { nil }
      it { expect(response.status).to eq(400) }
    end

    context 'with ignore_auth cs' do
      let(:cs) { 'estherilakegogogo' }
      it { expect(response).to be_success }
    end

    context 'compatiable for `HTTP_` prefix' do
      let(:headers) do
        {
          'HTTP_X_CS' => cs,
          'HTTP_X_TS' => ts
        }
      end
      it { expect(response).to be_success }
    end
  end
end
