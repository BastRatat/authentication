class Request < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
    validates :request_type, presence: true
    validates :description, presence: true
    validates :location, presence: true

    validates :request_type, inclusion: { in: ["one-time task", "material need"] }
end
