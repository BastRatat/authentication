require 'jwt'

module AuthorizationHelper
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
end
