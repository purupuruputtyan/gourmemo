class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :shop_name, null: false
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :menu, null: false
      t.text :impression, null: false
      t.integer :price
      t.integer :volume_status, null: false, default: 1
      t.string :star, null: false

      t.timestamps
    end
  end
end
