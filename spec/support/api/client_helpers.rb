# frozen_string_literal: true

module Api
  module ClientHelpers
    def api_request(method, path, params = {}, author_user = nil, headers = {})
      headers['AUTHORIZATION'] = generate_authorization(author_user) if author_user
      headers['X-TS'] = Time.now.to_i
      headers['X-CS'] = generate_checksum(headers['X-TS'])
      send(method, path, params, headers)
      # send(method, path, params: params, headers: args)
      JSON.parse(response.body)
    end
  end
end
