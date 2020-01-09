class CreatePostFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :post_favorites do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :post_favorites, [:user_id, :post_id], unique: true
  end
end
