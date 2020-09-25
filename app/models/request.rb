class Request < ApplicationRecord
    belongs_to :user
    has_many :requests
    has_many :volunteers
    has_many :chats

    validates :title, presence: true
    validates :request_type, presence: true
    validates :description, presence: true
    validates :location, presence: true

    validates :request_type, inclusion: { in: ["one-time task", "material need"] }
    validates :status, inclusion: { in: ["unfulfilled", "fulfilled"] }
end
