module Api
  module ClientAuthorizationConcern
    extend ActiveSupport::Concern
    include FetchHeaderConcern

    IGNORE_AUTH_CHECKSUM = 'estherilakegogogo'.freeze

    included do
      include ::Api::ErrorHandlerConcern unless method_defined?(:raise_api_error!)
      before_action :authorize_client
    end

    private

    def authorize_client
      return if ignore_auth?
      service = Api::ClientAuthService.new(fetch_header_value!('CS'), fetch_header_value!('TS'))
      unless service.run
        raise_api_error!(Api::AuthFailException, service.errors.full_messages)
      end
    end

    def ignore_auth?
      fetch_header_value!('CS') == IGNORE_AUTH_CHECKSUM && !Rails.env.production?
    end

  end
end
