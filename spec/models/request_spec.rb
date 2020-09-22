require 'rails_helper'

RSpec.describe Request do
    context "ASSOCIATION TESTS FOR REQUESTS" do
        it "should belong to a user" do
            user = Request.reflect_on_association(:user)
            expect(user.macro).to eq(:belongs_to)
        end
    end
end

RSpec.describe Request, type: :model do
  context 'VALIDATIONS TESTS FOR REQUESTS' do
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
