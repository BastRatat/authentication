require 'rails_helper'

RSpec.describe User, type: :model do
  context 'VALIDATIONS TESTS FOR USER' do
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

RSpec.describe User do
    context 'ASSOCIATION TESTS FOR USER' do
        it "should have many requests" do
            request = User.reflect_on_association(:requests)
            expect(request.macro).to eq(:has_many)
        end
    end
end
