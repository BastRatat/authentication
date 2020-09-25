class User < ApplicationRecord
    has_secure_password

    has_many :requests
    has_many :volunteers
    has_many :chats
    has_many :messages
    has_one :user

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
end
