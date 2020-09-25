require 'rails_helper'

RSpec.describe User, type: :request do
  context 'REQUESTS TESTS FOR USER' do
    it 'should render a user alongside a JWT' do
        post '/users',
        :params => {
            :first_name => 'First',
            :last_name => 'Last',
            :email => 'test@test.com',
            :password => '123456',
            :password_confirmation => '123456'
        }
        expect(response).to have_http_status(:ok)
    end

    it 'should login a user by returning a JWT' do
        post '/login',
        :params => {
            :email => 'test@test.com',
            :password => '123456',
        }
        expect(response).to have_http_status(:ok)
    end
  end
end
