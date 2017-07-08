module Common
  module ApiHelpers
    def generate_authorization
      jwt_auth = create(:jwt_authentication)
      auth_params = {
        key: jwt_auth.key,
        secret: jwt_auth.secret
      }
      service = Api::ClientAuthEncodeService.new(auth_params)
      service.run
      service.access_token
    end

    def generate_checksum(ts = nil)
      ts ||= Time.now.to_i
      client_key = Api::ClientAuthService::TEMP_SECRET_KEY
      Digest::MD5.hexdigest("#{client_key}-#{ts}")
    end

  end
end
