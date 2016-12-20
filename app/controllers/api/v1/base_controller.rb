module Api
  module V1
    class BaseController < ActionController::Base
      include ::Api::ErrorHandlerConcern
      include ::Api::ClientAuthorizationConcern

      before_action :set_default_format

      private

      def set_default_format
        request.format = 'json'
      end

      def render_ok
        render 'api/base/ok', status: 200
      end

      def render_get_access_token
        render 'api/base/access_token', status: 200
      end
    end
  end
end
