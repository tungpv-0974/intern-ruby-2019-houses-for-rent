class ChangImageUrlToImageOnPostPictures < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_pictures, :image_url, :image
  end
end
