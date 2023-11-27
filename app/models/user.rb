class User < ApplicationRecord
    has_many :shoppings, dependent: :destroy
    has_many :groups, dependent: :destroy
end