module Api
  module Users
    class SigninBaseService < ::BaseService
      attr_reader :access_token, :user

      before_run :find_user
      after_run :create_access_token

      def initialize(email, password)
        @email = email
        @password = password
      end

      def run
        run_callbacks :run do
          authorized?
        end
      end

      def authorized?
        fail "#authorized? not implement"
      end

      private

      def find_user
        @user = ::User.find_by_email(@email)
        unless @user
          errors.add(:user, 'not found')
          throw :abort
        end
      end

      def create_access_token
        @user = User.new({ email: @email, password: @password })
        service = Api::UserAuthEncodeService.new(@user)
        service.run
        @access_token = service.access_token
      end

    end
  end
end
