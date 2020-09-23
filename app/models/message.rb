class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :user_id, presence: true
  validates :chat_id, presence: true
  validates :author, presence: true
  validates :content, presence: true

  validates :author, inclusion: { in: [0, 1] }
end
