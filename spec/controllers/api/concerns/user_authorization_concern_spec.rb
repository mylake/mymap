require 'rails_helper'

class FoosController < ActionController::Base; end

RSpec.describe Api::UserAuthorizationConcern, type: :controller, api: true do
  controller(FoosController) do
    include Api::UserAuthorizationConcern

    before_action :api_authenticate_user!

    def index
      render json: { ok: true }
    end
  end

  before {
    routes.draw {
      get 'index' => 'foos#index'
    }
  }

  let(:user) { create(:user) }

  describe 'success result' do
    let(:headers) do
      {
        'Authorization' => generate_authorization(user),
      }
    end
    before { @request.env.merge!(headers) }

    subject! { get :index }

    it { expect(response.status).to eq(200) }

    describe 'invalid token' do
      let(:headers) do
        {
          'Authorization' => 'invalid token',
        }
      end

      it { expect(response.status).to eq(401) }
    end
  end

end
