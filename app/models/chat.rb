class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :request
  belongs_to :volunteer

  validates :user_id, presence: true
  validates :request_id, presence: true
  validates :volunteer_id, presence: true
end
