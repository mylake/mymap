module Api
  module Places
    class UpdateService < ::BaseService

      attr_reader :place
      validate :check_my_place

      def initialize(place_id, params, user)
        @place_id = place_id
        @params = params
        @user = user
      end

      def run
        return false unless valid?
        @place.update(@params)
      end

      private

      def check_my_place
        @place = Place.find_by(id: @place_id)
        errors.add(:base, 'not your places') if @place.id != @user.id
      end

    end
  end
end
