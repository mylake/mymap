module Api
  module UserAuthorizationConcern
    extend ActiveSupport::Concern

    included do
      include ::Api::ErrorHandlerConcern unless method_defined?(:raise_api_error!)
    end

    private

    def api_authenticate_user!
      raise_api_error!(Api::AuthFailException, @api_user_auth_service.errors.full_messages) unless api_user_signed_in?
    end

    def api_user_signed_in?
      api_current_user.present?
    end

    def api_current_user
      @api_user_auth_service ||= Api::UserAuthDecodeService.new(request.headers.env['Authorization'])
      @api_user_auth_service.run
      @api_current_user ||= @api_user_auth_service.api_current_user
    end

  end
end
