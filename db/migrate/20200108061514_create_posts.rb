class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :active
      t.integer :total_bathroom
      t.integer :total_bedroom
      t.integer :area
      t.integer :price
      t.integer :house_type
      t.integer :user_id
      t.string :address
      t.integer :ward_id

      t.timestamps
    end
  end
end
