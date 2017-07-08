module Api
  class UserAuthEncodeService < ::BaseService

    SECRET_KEY = 'esther-ilake-gogogo'.freeze
    EXPIRED_INTERVAL = 1.month

    before_run :check_params

    attr_reader :access_token

    def initialize(user)
      @id = user.id
      @email = user.email
    end

    def run
      run_callbacks :run do
        generate_access_token
        true
      end
    end

    private

    def check_params
      return if @id && @emaik
      errors.add(:base, 'no id or email')
      false
    end

    def generate_access_token
      payload = {
        id: @id,
        email: @email,
        datetime: DateTime.now.to_i
      }
      @access_token = JWT.encode(payload, SECRET_KEY, 'HS256')
    end

  end
end
