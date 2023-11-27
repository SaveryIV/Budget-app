class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.references :users, null: false, foreign_key: { on_delete: :cascade }
      t.references :shoppings, null: false, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
