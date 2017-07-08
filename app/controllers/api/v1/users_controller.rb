module Api
  module V1
    class UsersController < BaseController

      def create
        @user = User.new(user_params)
        if @user.save
          service = Api::UserAuthEncodeService.new(@user)
          service.run
          @access_token = service.access_token
        else
          raise_api_error!(Api::AuthFailException, service.errors.full_messages)
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

    end
  end
end
