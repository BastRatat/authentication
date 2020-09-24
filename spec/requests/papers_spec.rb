require 'rails_helper'
require_relative '../helpers/tests_helper'

RSpec.describe "/papers", type: :request do

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
    @user_id = retrieve_id(@auth_token)

  end

  let(:valid_attributes) {
    {
      user_id: @user_id,
      official: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/public/test.jpg')))
    }
  }

  let(:valid_headers) {
    {
      "authorization" => "bearer #{@auth_token}",
      "content-type" => "multipart/form-data" }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Paper.create! valid_attributes
      get "/files",
        headers: valid_headers,
        as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      file = Paper.create! valid_attributes
      get "/file/#{file.id}",
        headers: valid_headers,
        as: :json
      expect(response).to be_successful
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested paper" do
      file = Paper.create! valid_attributes
      expect {
        delete "/file/#{file.id}",
        headers: valid_headers,
        as: :json
      }.to change(Paper, :count).by(-1)
    end
  end
end
