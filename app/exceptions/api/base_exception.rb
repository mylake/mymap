module Api
  class BaseException < RuntimeError
    attr_accessor :message, :data

    def initialize(data = {})
      @data = data
      @message = @data.delete(:message)
    end

    def http_status
      raise 'You must define http status code'
    end

    def to_code
      self.class.to_s.underscore.split('/').last
    end

  end
end
