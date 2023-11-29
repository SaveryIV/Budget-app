class Group < ApplicationRecord
  has_many :group_shoppings, dependent: :destroy
  has_many :shoppings, through: :group_shoppings, foreign_key: 'shoppings_id'

  belongs_to :user

  validates :name, presence: true, length: { maximum: 36 },
                   uniqueness: { scope: :user, message: 'User has already a group with this name' }
  validates :icon, presence: true, length: { maximum: 250 }
end
