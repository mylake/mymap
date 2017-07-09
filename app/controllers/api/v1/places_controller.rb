module Api
  module V1
    class PlacesController < BaseController

      before_action :api_authenticate_user!

      def create
        service = Api::Places::CreateService.new(place_params, api_current_user)
        if service.run
          @place = service.place
        else
          raise_api_error!(Api::CreateFailException, service.errors.full_messages)
        end
      end

      private

      def place_params
        params.require('place').permit(:name, :lat, :lon, :map_id, :category, :desc)
      end
    end
  end
end
