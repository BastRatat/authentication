require 'rails_helper'

RSpec.describe Chat, type: :model do
  context "VALIDATIONS TESTS FOR CHATS" do
      it "ensures user_id presence" do
          chat = Chat.new(request_id: 1, volunteer_id: 1).save
          expect(chat).to eq(false)
      end

      it "ensures request_id presence" do
          chat = Chat.new(user_id: 1, volunteer_id: 1).save
          expect(chat).to eq(false)
      end

      it "ensures volunteer_id presence" do
          chat = Chat.new(user_id: 1, request_id: 1).save
          expect(chat).to eq(false)
      end
  end
end

RSpec.describe Chat do
    context 'ASSOCIATION TESTS FOR CHATS' do
        it "should belong to User" do
            user = Chat.reflect_on_association(:user)
            expect(user.macro).to eq(:belongs_to)
        end

        it "should belong to Request" do
            request = Chat.reflect_on_association(:request)
            expect(request.macro).to eq(:belongs_to)
        end

        it "should belong to Volunteer" do
            volunteer = Chat.reflect_on_association(:volunteer)
            expect(volunteer.macro).to eq(:belongs_to)
        end
    end
end
