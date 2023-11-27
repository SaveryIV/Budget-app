class Group < ApplicationRecord
    belongs_to :users

    validates :name, presence: true, length: { maximum: 36 }, uniqueness: { scope: :user, message: 'User has already a group with this name' }
    validates :icon, presence: true, length: { maximum: 250 }
end