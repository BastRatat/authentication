class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :request
  has_many :chats

  validates :user_id, presence: true
  validates :request_id, presence: true
end
