require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should create user" do
    assert_difference 'User.count' do
      post '/users', params: { user: { email:'test@test.test', password: 'Hello123456', password_confirmation: 'Hello123456', first_name: 'Test', last_name: 'Test' } }, as: :json
    end

    assert_response 200
  end

  test "should log in user" do
    post '/login', params: { user: { email: 'test@test.test', password: 'Hello123456' } }, as: :json
    assert_response 200
  end

end
