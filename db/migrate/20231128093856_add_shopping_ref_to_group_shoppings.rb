class AddShoppingRefToGroupShoppings < ActiveRecord::Migration[7.1]
  def change
    add_reference :group_shoppings, :shoppings, null: false, foreign_key: { on_delete: :cascade }
  end
end
