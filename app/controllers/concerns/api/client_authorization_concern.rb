module Api
  module ClientAuthorizationConcern
    extend ActiveSupport::Concern

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

    def fetch_header_value!(key)
      key2 = key.tr('-', '_')
      @header_params ||= ActionController::Parameters.new(request.headers.to_h)
      @header_params[key] ||
        @header_params["HTTP_#{key}"] ||
        @header_params["HTTP_X_#{key}"] ||
        @header_params["X-#{key}"] ||
        @header_params[key2] ||
        @header_params["HTTP_#{key2}"] ||
        @header_params["HTTP_X_#{key2}"] ||
        @header_params["X-#{key2}"] ||
        @header_params.require(key)
    end

  end
end
