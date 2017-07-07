module Api
  module Users
    class SigninByEmailService < SigninBaseService

      def initialize(email, password)
        @email = email
        @password = password
      end

      def authorized?
        if @user.valid_password?(@password)
          true
        else
          errors.add(:password, 'not valid')
          false
        end
      end

    end
  end
end
