class CreateGroupShoppings < ActiveRecord::Migration[7.1]
  def change
    create_table :group_shoppings do |t|

      t.timestamps
    end
  end
end
