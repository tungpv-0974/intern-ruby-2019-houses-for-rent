class PostPicture < ApplicationRecord
  belongs_to :post
  mount_uploader :image, PictureUploader
end
