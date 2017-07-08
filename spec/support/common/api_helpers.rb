module Common
  module ApiHelpers
    def generate_authorization(user)
      service = Api::UserAuthEncodeService.new(user)
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
