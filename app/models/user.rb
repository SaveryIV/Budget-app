class User < ApplicationRecord
    has_many :shoppings, dependent: :destroy
    has_many :groups, dependent: :destroy

    validates :name, presence: true, length: { maximum: 36 }
end