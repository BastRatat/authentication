require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures first name presence' do
        user = User.new(last_name: 'Last', email: 'test@test.com', password: '123456', password_confirmation:'123456').save
        expect(user).to eq(false)
    end

    it 'ensures last name presence' do
        user = User.new(first_name: 'First', email: 'test@test.com', password: '123456', password_confirmation:'123456').save
        expect(user).to eq(false)
    end

    it 'ensures email presence' do
        user = User.new(first_name: 'First', last_name: 'Last', password: '123456', password_confirmation:'123456').save
        expect(user).to eq(false)
    end

    it 'should save user' do
        user = User.new(first_name: 'First', last_name: 'Last', email: 'test@test.com', password: '123456', password_confirmation:'123456').save
        expect(user).to eq(true)
    end
  end
end

RSpec.describe User, type: :request do
  context 'controller tests' do
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
  end
end
