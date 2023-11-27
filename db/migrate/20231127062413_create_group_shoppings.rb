class CreateGroupShoppings < ActiveRecord::Migration[7.1]
  def change
    create_table :group_shoppings do |t|
      t.references :group, null: false, foreign_key: {on_delete: :cascade}
      t.references :shopping, null: false, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
