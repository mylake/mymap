module Api
  module FetchHeaderConcern
    extend ActiveSupport::Concern

    def fetch_header_value!(key)
      key2 = key.tr('-', '_')
      @header_params ||= ActionController::Parameters.new(request.headers.to_h)
      @header_params[key] ||
        @header_params["HTTP_#{key}"] ||
        @header_params["HTTP_X_#{key}"] ||
        @header_params["X-#{key}"] ||
      @header_params[key2] ||
        @header_params["HTTP_#{key2}"] ||
        @header_params["HTTP_X_#{key2}"] ||
        @header_params["X-#{key2}"] ||
      @header_params.require(key)
    end

  end
end
