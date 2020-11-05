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

    it 'ensures description length is inferior to 300 chars' do
        request = Request.new(user_id: 1, title: "Test request", request_type: 'one-time task', description: '35BcVQ2M8FW9POPPvelD2NCw34Id1i0Vuzw4i0xSo0xwIhEyni00bKvjGVXIIF38q4SVdheF82lDrWS28oYSIctuAYpQ2zMvFHMNjxC2cVR8ZzruZfy7v4h2Jpqv9RApnaTGTb0P6cPMeeVilCFUzvgMFA4bhgXLOuKBpJG2kJ8hsejtJ5fqK0tiQdWD5tvgeXh1kdSbvonByKnLMBNQoanyiHwIe1xPyKe4c7rYApOB9qgirnGfcMNM7d53Qsc0dKjF3pPIhA7LXXjkzyRkG9FxG59V281SR2LHwUd9CDTEAQ5Ntc3US5YBndD73s5WiNKmCp9qfVf3DaZZr4DK35BcVQ2M8FW9POPPvelD2NCw34Id1i0Vuzw4i0xSo0xwIhEyni00bKvjGVXIIF38q4SVdheF82lDrWS28oYSIctuAYpQ2zMvFHMNjxC2cVR8ZzruZfy7v4h2Jpqv9RApnaTGTb0P6cPMeeVilCFUzvgMFA4bhgXLOuKBpJG2kJ8hsejtJ5fqK0tiQdWD5tvgeXh1kdSbvonByKnLMBNQoanyiHwIe1xPyKe4c7rYApOB9qgirnGfcMNM7d53Qsc0dKjF3pPIhA7LXXjkzyRkG9FxG59V281SR2LHwUd9CDTEAQ5Ntc3US5YBndD73s5WiNKmCp9qfVf3DaZZr4DK', status: false).save
        expect(request).to eq(false)
    end
  end
end
