module ChatsHelper
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
