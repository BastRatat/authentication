require 'rails_helper'

RSpec.describe Message, type: :model do
  context "VALIDATIONS TESTS FOR MESSAGES" do
      it "ensures user_id presence" do
          message = Message.new(chat_id: 1, author: 0, content: "sample message").save
          expect(message).to eq(false)
      end

      it "ensures chat_id presence" do
          message = Message.new(user_id: 1, author: 0, content: "sample message").save
          expect(message).to eq(false)
      end

      it "ensures author presence" do
          message = Message.new(user_id: 1, chat_id: 1, content: "sample message").save
          expect(message).to eq(false)
      end

      it "ensures content presence" do
          message = Message.new(user_id: 1, chat_id: 1, author: 0).save
          expect(message).to eq(false)
      end
  end
end

RSpec.describe Message do
    context 'ASSOCIATION TESTS FOR MESSAGES' do
        it "should belong to User" do
            user = Message.reflect_on_association(:user)
            expect(user.macro).to eq(:belongs_to)
        end

        it "should belong to Chat" do
            chat = Message.reflect_on_association(:chat)
            expect(chat.macro).to eq(:belongs_to)
        end

    end
end

