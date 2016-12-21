module Api
  class ClientAuthDecodeService < ::BaseService

    SECRET_KEY = Api::ClientAuthEncodeService.const_get('SECRET_KEY')
    EXPIRED_INTERVAL = Api::ClientAuthEncodeService.const_get('EXPIRED_INTERVAL')

    before_run :check_access_token_exist?

    def initialize(access_token)
      @access_token = access_token
    end

    def run
      run_callbacks :run do
        begin
          decoded_token = JWT.decode(@access_token, SECRET_KEY, true, algorithm: 'HS256')
          decoded_token = HashWithIndifferentAccess.new(decoded_token.first)
          @key = decoded_token[:key]
          @secret = decoded_token[:secret]
          @datetime = decoded_token[:datetime]
          not_expired? && is_third_party_register?
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

    def is_third_party_register?
      return true if JwtAuthentication.registered?(@key, @secret)
      errors.add(:base, 'unauthenticated')
      false
    end

  end
end
