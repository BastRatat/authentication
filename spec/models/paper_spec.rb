=begin
require 'rails_helper'

file = fixture_file_upload(Rails.root.join('public', 'test.jpg'), 'image/jpg')

RSpec.describe Paper, type: :model do
  context "VALIDATIONS TESTS FOR UPLOADING FILES" do
      it "ensures user_id presence" do
          file = Paper.new(official: @file).save
          expect(file).to eq(false)
      end

      it "ensures file presence" do
          file = Paper.new(user_id: 1).save
          expect(file).to eq(false)
      end
  end
end
=end
