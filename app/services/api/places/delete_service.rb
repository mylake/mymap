module Api
  module Places
    class DeleteService < ::BaseService

      validate :check_my_place

      def initialize(place_id, user)
        @place_id = place_id
        @user = user
      end

      def run
        return false unless valid?
        @place.destroy
      end

      private

      def check_my_place
        @place = Place.find_by(id: @place_id)
        errors.add(:base, 'not your places') if @place.user_id != @user.id
      end

    end
  end
end
