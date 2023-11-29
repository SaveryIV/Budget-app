class GroupShopping < ApplicationRecord
  belongs_to :group
  belongs_to :shopping, foreign_key: 'shoppings_id'

  validates :shopping, uniqueness: { scope: :group }
end
