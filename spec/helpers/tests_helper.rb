module TestsHelper

    # 1. Methods for authentication
    def sign_up(user)
        post '/users',
        params: {
            first_name: user[:first_name],
            last_name: user[:last_name],
            email: user[:email],
            password: user[:password],
            password_confirmation: user[:password]
        },
        headers: {
            "content-type" => "application/json"
        },
        as: :json
        response
    end

    def retrieve_id(token)
        decoded_token = JWT.decode(token, nil, false)
        return decoded_token[0]['user_id']
    end

    def auth_token(user)
        post '/login',
        params: {
            email: user[:email],
            password: user[:password]
        }
        res = JSON.parse(response.body)
        token = res['jwt']
        return token
    end

    # 2. Methods for the Request model
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

    # 3. Methods for the Volunteer model
    def create_volunteer(request_id, volunteer_data, token)
        post "/requests/#{request_id}/volunteers",
        params: volunteer_data,
        headers: {
            "authorization" => "bearer #{token}"
        },
        as: :json
        res = JSON.parse(response.body)
        volunteer_id = res['id']
        return volunteer_id
    end

    # 4. Methods for the Chat model
    def create_chat(request_id, chat_data, token)
        post "/requests/#{request_id}/chats",
        params: chat_data,
        headers: {
            "authorization" => "bearer #{token}"
        },
        as: :json
        res = JSON.parse(response.body)
        chat_id = res['id']
        return chat_id
    end
end
