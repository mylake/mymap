module Api
  class CreateFailException < BaseException

    def http_status
      400
    end

  end
end
