class GroupShopping < ApplicationRecord
    belongs_to :groups
    belongs_to :shoppings
  
    validates :shopping, uniqueness: { scope: :group }
end