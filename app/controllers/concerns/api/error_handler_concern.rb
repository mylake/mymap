module Api
  module ErrorHandlerConcern
    extend ActiveSupport::Concern

    included do
      rescue_from Api::BaseException do |e|
        render_error e, status: e.http_status
      end

      rescue_from ActionController::ParameterMissing do |e|
        def e.to_code; self.class.to_s.underscore.split('/').last; end
        unless Rails.env.production?
          @custom_error_message = "#{ e.message }. \n[debug]\n params: #{ params.inspect }\n headers:#{ request.headers.to_h.select { |k, v| v.to_s.length < 1000 }.inspect }"
        end
        render_error e, status: 400
      end
    end

    private

    def raise_api_error!(exception_class, message = nil, data = {})
      message = message.join('\n') if message.is_a?(Array)
      fail exception_class.new(data.merge(message: message))
    end

    def render_error(e, status: 400)
      @exception = e
      render 'api/base/error', status: status
    end

  end
end
