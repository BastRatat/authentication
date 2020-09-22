require 'rails_helper'
require_relative '../authentication_helper'
require_relative '../requests_helper'
require_relative '../volunteer_helper'

RSpec.describe "/chats", type: :request do

  include AuthorizationHelper
  include RequestsHelper
  include VolunteersHelper

  setup do
    # Mock a user
    test_user_one = {
      email: "test@test.test",
      password: "123456",
      first_name: "First",
      last_name: "Last"
    }

    test_user_two = {
      email: "two@two.two",
      password: "123456",
      first_name: "Firsttwo",
      last_name: "Lasttwo"
    }

    # Sign up user that creates a request
    sign_up(test_user_one)
    @auth_token_one = auth_token(test_user_one)
    @user_one = retrieve_id(@auth_token_one)

    # Mock a request
    test_request = {
      user_id: @user_one,
      title: "Request from user one",
      request_type: "one-time task",
      description: "testing a request for the sake of testing our chat table",
      location: "Marseille"
    }
    @request_one = create_user(test_request, @auth_token_one)

    # Sign up a user that would be a volunteer
    sign_up(test_user_two)
    @auth_token_two = auth_token(test_user_two)
    @user_two = retrieve_id(@auth_token_two)

    # Mock a volunteer
    test_volunteer = {
      user_id: @user_two,
      request_id: @request_one
    }
    @volunteer = create_volunteer(@request_one, test_volunteer, @auth_token_two)
  end

  let(:valid_attributes) {
    {
      :user_id => "#{@user_one}",
      :volunteer_id => "#{@volunteer}",
      :request_id => "#{@request_one}"
    }
  }

  let(:valid_headers) {
    {
      "authorization" => "bearer #{@auth_token_two}"
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      chat = Chat.create! valid_attributes
      get "/requests/#{chat.id}/chats",
      headers: valid_headers,
      as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      chat = Chat.create! valid_attributes
      get "/chat/#{chat.id}",
      as: :json,
      headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Chat" do
        expect {
          post "/requests/#{@request_one}/chats",
               params: valid_attributes,
               headers: valid_headers,
               as: :json
        }.to change(Chat, :count).by(1)
      end

      it "renders a JSON response with the new chat" do
        post "/requests/#{@request_one}/chats",
             params: valid_attributes,
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested chat" do
      chat = Chat.create! valid_attributes
      expect {
        delete "/chat/#{chat.id}",
        headers: valid_headers,
        as: :json
      }.to change(Chat, :count).by(-1)
    end
  end
end

