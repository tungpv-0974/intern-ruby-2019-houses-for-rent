class Post < ApplicationRecord
  belongs_to :user
  has_many :post_pictures, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :like_users, through: :post_favorites, source: :user
  belongs_to :ward, optional: true
end
