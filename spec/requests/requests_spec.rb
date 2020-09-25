require 'rails_helper'
require_relative '../helpers/tests_helper'

RSpec.describe "/requests", type: :request do

  include TestsHelper

  setup do
    test_user = {
      email: "test@test.test",
      password: "123456",
      first_name: "First",
      last_name: "Last"
    }
    sign_up(test_user)
    @auth_token = auth_token(test_user)
    @user = retrieve_id(@auth_token)
  end

  let(:valid_attributes) {
    {
      :user_id => "#{@user}",
      :title => 'Test title',
      :request_type => 'one-time task',
      :description => 'test',
      :location => 'Marseille'
    }
  }

  let(:invalid_attributes) {
      {
        "user_id" => @user,
        "title" => "Test title",
        "request_type" => "one-time task",
        "description" => "test description for test request"
    }
  }

  let(:valid_headers) {
    {
      "authorization" => "bearer #{@auth_token}"
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Request.create! valid_attributes
      get requests_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      request = Request.create! valid_attributes
      get request_url(request), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Request" do
        expect {
          post requests_url,
               params: valid_attributes, headers: valid_headers, as: :json
        }.to change(Request, :count).by(1)
      end

      it "renders a JSON response with the new request" do
        post requests_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { "request_type" => "material need" }
      }

      it "updates the requested request" do
        request = Request.create! valid_attributes
        patch request_url(request),
              params: invalid_attributes, headers: valid_headers, as: :json
        request.reload
      end

      it "renders a JSON response with the request" do
        request = Request.create! valid_attributes
        patch request_url(request),
              params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested request" do
      request = Request.create! valid_attributes
      expect {
        delete request_url(request), headers: valid_headers, as: :json
      }.to change(Request, :count).by(-1)
    end
  end
end
