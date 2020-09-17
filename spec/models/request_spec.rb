require 'rails_helper'
require_relative '../authentication_helper'
require 'jwt'

RSpec.describe Request do
    context "ASSOCIATION TESTS" do
        it "should belong to a user" do
            user = Request.reflect_on_association(:user)
            expect(user.macro).to eq(:belongs_to)
        end
    end
end


RSpec.describe Request, type: :model do
  context 'VALIDATIONS TESTS' do
    it 'ensures title presence' do
        request = Request.new(user_id: 1, request_type: 'one-time task', description: 'request content', location: 'London', status: false).save
        expect(request).to eq(false)
    end

    it 'ensures type presence' do
        request = Request.new(user_id: 1, title: "Test request", description: 'request content', location: 'London', status: false).save
        expect(request).to eq(false)
    end

    it 'ensures description presence' do
        request = Request.new(user_id: 1, title: "Test request", request_type: 'one-time task', location: 'London', status: false).save
        expect(request).to eq(false)
    end

    it 'ensures location presence' do
        request = Request.new(user_id: 1, title: "Test request", request_type: 'one-time task', description: 'request content', status: false).save
        expect(request).to eq(false)
    end
  end
end

RSpec.describe Request, type: :request do

  include AuthorizationHelper

  setup do
    test_user = {
      email: "test@test.com",
      password: "123456",
      first_name: "First",
      last_name: "Last"
    }
    sign_up(test_user)
    @auth_token = auth_token(test_user)
    @user = retrieve_id(@auth_token)
  end

  context 'REQUESTS TESTS' do
    it "saves a request" do
        post '/requests',
        :params => {
            :user_id => "#{@user}",
            :title => 'Test title',
            :request_type => 'one-time task',
            :description => 'test',
            :location => 'Marseille',
            :status => false
        },
        :headers => {
            "authorization" => "bearer #{@auth_token}"
        }
        retrieve_id(@auth_token)
        expect(response).to have_http_status(:created)
    end

    it "ensures a user can retrieve all requests" do
        get '/requests',
        :headers => {
            "authorization" => "bearer #{@auth_token}"
        }
        expect(response).to have_http_status(:ok)
    end
  end
end

