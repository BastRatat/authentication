module RequestsHelper
    def create_request(request_data, token)
        # Take test request data and test user JWT to create a request
        # Return the request ID
        post '/requests',
        params: request_data,
        headers: {
            "authorization" => "bearer #{token}"
        },
        as: :json
        res = JSON.parse(response.body)
        request_id = res['id']
        return request_id
    end
end
