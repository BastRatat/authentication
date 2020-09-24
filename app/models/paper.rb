class Paper < ApplicationRecord
  belongs_to :user
  has_one_attached :official

  validates :official, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'] }
end
