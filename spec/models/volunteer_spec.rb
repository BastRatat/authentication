require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  context "VALIDATIONS TESTS" do
      it "ensures user_id presence" do
          volunteer = Volunteer.new(request_id: 1).save
          expect(volunteer).to eq(false)
      end

      it "ensures request_id presence" do
          volunteer = Volunteer.new(user_id: 1).save
          expect(volunteer).to eq(false)
      end
  end
end
