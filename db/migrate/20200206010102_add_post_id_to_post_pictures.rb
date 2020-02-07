class AddPostIdToPostPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :post_pictures, :post_id, :integer
  end
end
