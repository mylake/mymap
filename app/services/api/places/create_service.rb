module Api
  module Places
    class CreateService < ::BaseService

      attr_reader :place

      def initialize(params, user)
        @params = params
        @user = user
      end

      def run
        @place = @user.places.create(@params)
      end
    end
  end
end
