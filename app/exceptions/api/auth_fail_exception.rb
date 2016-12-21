module Api
  class AuthFailException < BaseException

    def http_status
      401

    end
  end
end
