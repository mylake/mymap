module Api
  class ClientAuthEncodeService < ::BaseService

    SECRET_KEY = 'esther-ilake-gogogo'.freeze
    EXPIRED_INTERVAL = 1.month

    before_run :check_params

    attr_reader :access_token

    def initialize(params)
      @params = ActionController::Parameters.new(params)
      @key = @params[:key]
      @secret = @params[:secret]
    end

    def run
      run_callbacks :run do
        generate_access_token
        true
      end
    end

    private

    def check_params
      return if @key && @secret
      errors.add(:base, 'no key or secret')
      false
    end

    def generate_access_token
      payload = {
        key: @key,
        secret: @secret,
        datetime: DateTime.now.to_i
      }
      @access_token = JWT.encode(payload, SECRET_KEY, 'HS256')
    end

  end
end
