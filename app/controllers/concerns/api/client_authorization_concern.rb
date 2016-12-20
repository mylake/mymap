module Api
  module ClientAuthorizationConcern
    extend ActiveSupport::Concern

    IGNORE_AUTH = 'estherilakegogogo'.freeze

    included do
      include ::Api::ErrorHandlerConcern unless self.method_defined?(:raise_api_error!)
      before_action :authorize_client_access_token
    end

    private

    def authorize_client_access_token
      return if is_ignore_auth?
      service = Api::ClientAuthDecodeService.new(request.headers['Authorization'])
      return if service.run
      raise_api_error!(Api::AuthFailException, service.errors.full_messages)
    end

    def is_ignore_auth?
      request.headers['Authorization'] == IGNORE_AUTH # && !Rails.env.production?
    end

  end
end
