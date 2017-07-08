module Api
  module UserAuthorizationConcern
    extend ActiveSupport::Concern

    included do
      include ::Api::ErrorHandlerConcern unless self.method_defined?(:raise_api_error!)
    end

    private

    def api_current_user
      @api_user_auth_service ||= Api::ClientAuthDecodeService.new(request.headers['Authorization'])
      @api_user_auth_service.run
      @api_current_user ||= @api_user_auth_service.api_current_user
    end

  end
end
