module Api
  module ClientHelpers
    def api_request(method, path, params = {}, need_auth_header = true, *args)
      if need_auth_header
        args[0] ||= {}
        # args[0]['Authorization'] = generate_authorization
        args[0]['Authorization'] = 'estherilakegogogo'
      end
      send(method, path, { params: params, headers: args })
      JSON.parse(response.body)
    end
  end
end
