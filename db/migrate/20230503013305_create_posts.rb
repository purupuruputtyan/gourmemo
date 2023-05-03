class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :shop_name, null: false
      t.string :menu, null: false
      t.text :impression
      t.integer :price
      t.integer :volume_status, default: 1
      t.string :star, null: false

      t.timestamps
    end
  end
end
