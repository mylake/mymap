module Api
  module V1
    class SessionsController < BaseController

      skip_before_action :authorize_client_access_token

      def create
        service = Api::Users::SigninByEmailService.new(sign_in_params[:email], sign_in_params[:password])
        if service.run
          @access_token = service.access_token
        else
          raise_api_error!(Api::AuthFailException, service.errors.full_messages)
        end
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password, :provider, :uid, :access_token)
      end



    end
  end
end
