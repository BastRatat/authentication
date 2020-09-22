module VolunteersHelper
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
end
