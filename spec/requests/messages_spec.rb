require 'rails_helper'
require_relative '../helpers/tests_helper'

RSpec.describe "/messages", type: :request do

  include TestsHelper

  setup do

    # 1. Mock up first user, generate a JWT & retrieve user_id
    test_user_one = {
      email: "test@test.test",
      password: "123456",
      first_name: "First",
      last_name: "Last"
    }
    sign_up(test_user_one)
    @auth_token_one = auth_token(test_user_one)
    @user_one = retrieve_id(@auth_token_one)

    # 2. Mock up first user's request
    test_request = {
      user_id: @user_one,
      title: "Request from user one",
      request_type: "one-time task",
      description: "testing a request for the sake of testing our message table",
      location: "Marseille"
    }
    @request_id = create_request(test_request, @auth_token_one)

    # 3. Mock up second user
    test_user_two = {
      email: "two@two.two",
      password: "123456",
      first_name: "Firsttwo",
      last_name: "Lasttwo"
    }
    sign_up(test_user_two)
    @auth_token_two = auth_token(test_user_two)
    @user_two = retrieve_id(@auth_token_two)

    # 4. Mock up second user becoming a volunteer of the first user request
    test_volunteer = {
      user_id: @user_two,
      request_id: @request_id
    }
    volunteer = Volunteer.create! test_volunteer
    @volunteer = create_volunteer(@request_id, test_volunteer, @auth_token_two)

    # 5. Mock up chat creation between user one and user two
    test_chat = {
      user_id: @user_one,
      volunteer_id: @volunteer,
      request_id: @request_id
    }

    @chat_id = create_chat(@request_id, test_chat, @auth_token_two)
  end

  let(:valid_attributes) {
    {
      chat_id: @chat_id,
      user_id: @user_two,
      author: 1,
      content: "Hey, I am interested to help you with your request"
    }
  }

  let(:valid_headers) {
    { "authorization" => "bearer #{@auth_token_two}" }
  }

  describe "GET /index" do
    it "renders a successful response" do
      message = Message.create! valid_attributes
      get "/chat/#{@chat_id}/messages",
      headers: valid_headers,
      as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Message" do
        expect {
          post "/chat/#{@chat_id}/messages",
            params: valid_attributes ,
            headers: valid_headers,
            as: :json
        }.to change(Message, :count).by(1)
      end

      it "renders a JSON response with the new message" do
        post "/chat/#{@chat_id}/messages",
          params: valid_attributes,
          headers: valid_headers,
          as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
