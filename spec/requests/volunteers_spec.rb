require 'rails_helper'
require_relative '../helpers/tests_helper'

RSpec.describe "/volunteers", type: :request do

  include TestsHelper

  setup do
    # Mock a user
    test_user = {
      email: "test@test.test",
      password: "123456",
      first_name: "First",
      last_name: "Last"
    }
    sign_up(test_user)
    @auth_token = auth_token(test_user)
    @user = retrieve_id(@auth_token)

    # Mock a request
    test_request = {
      user_id: @user,
      title: "Testing a request",
      request_type: "one-time task",
      description: "testing a request for the sake of testing our volunteer table",
      location: "Marseille"
    }
    @request = create_request(test_request, @auth_token)
  end

  let(:valid_attributes) {
    {
      :user_id => "#{@user}",
      :request_id => "#{@request}"
    }
  }

  let(:valid_headers) {
    {
      "authorization" => "bearer #{@auth_token}"
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      volunteer = Volunteer.create! valid_attributes
      get "/requests/#{volunteer.id}/volunteers", headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      volunteer = Volunteer.create! valid_attributes
      get "/volunteer/#{volunteer.id}",
      headers: valid_headers,
      as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Volunteer" do
        expect {
          post "/requests/#{@request}/volunteers",
            params: valid_attributes,
            headers: valid_headers,
            as: :json
        }.to change(Volunteer, :count).by(1)
      end

      it "renders a JSON response with the new volunteer" do
        post "/requests/#{@request}/volunteers",
          params: valid_attributes,
          headers: valid_headers,
          as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested volunteer" do
      volunteer = Volunteer.create! valid_attributes
      expect {
        delete "/volunteer/#{volunteer.id}",
        headers: valid_headers,
        as: :json
      }.to change(Volunteer, :count).by(-1)
    end
  end
end
