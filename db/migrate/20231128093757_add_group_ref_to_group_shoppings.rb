class AddGroupRefToGroupShoppings < ActiveRecord::Migration[7.1]
  def change
    add_reference :group_shoppings, :group, null: false, foreign_key: true
  end
end
