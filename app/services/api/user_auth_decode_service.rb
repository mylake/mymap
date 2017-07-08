module Api
  class UserAuthDecodeService < ::BaseService

    SECRET_KEY = Api::UserAuthEncodeService.const_get('SECRET_KEY')
    EXPIRED_INTERVAL = Api::UserAuthEncodeService.const_get('EXPIRED_INTERVAL')

    before_run :check_access_token_exist?
    attr_reader :api_current_user

    def initialize(access_token)
      @access_token = access_token
    end

    def run
      run_callbacks :run do
        begin
          decoded_token = JWT.decode(@access_token, SECRET_KEY, true, algorithm: 'HS256')
          decoded_token = HashWithIndifferentAccess.new(decoded_token.first)
          @id = decoded_token[:id]
          @email = decoded_token[:email]
          @datetime = decoded_token[:datetime]
          not_expired? && get_user
        rescue => e
          Rails.logger.info { "Api::ClientAuthDecode failed: #{e}" }
          errors.add(:base, 'unauthenticated')
          return false
        end
      end
    end

    private

    def check_access_token_exist?
      return if @access_token.present?
      errors.add(:base, 'empty access token')
      false
    end

    def not_expired?
      return true if (EXPIRED_INTERVAL.ago.to_i..(Time.now.to_i)).cover?(@datetime)
      errors.add(:base, "must use access token within #{(EXPIRED_INTERVAL / 1.minute).to_i} minutes")
      false
    end

    def get_user
      @api_current_user = User.where(id: @id, email: @email).first
      return true if @api_current_user
      errors.add(:base, 'unauthenticated')
      false
    end

  end
end
