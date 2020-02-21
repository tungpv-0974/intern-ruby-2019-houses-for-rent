class AddStatusToPostFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :post_favorites, :status, :integer, default: 0
  end
end
