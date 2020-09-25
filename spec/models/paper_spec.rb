require 'rails_helper'

RSpec.describe Paper, type: :model do
  context "VALIDATIONS TESTS FOR UPLOADING FILES" do
      it "ensures user_id presence" do
          file = Paper.new(official: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/public/test.jpg')))).save
          expect(file).to eq(false)
      end

      it "ensures file presence" do
          file = Paper.new(user_id: 1).save
          expect(file).to eq(false)
      end
  end
end

RSpec.describe Paper do
    context "ASSOCIATION TESTS FOR THE GOVERNMENT ID" do
        it "should belong to a user" do
            user = Paper.reflect_on_association(:user)
            expect(user.macro).to eq(:belongs_to)
        end
    end
end
