class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_likes, through: :post_favorites, source: :post
  belongs_to :identify_card, optional: true, dependent: :destroy
  belongs_to :ward, optional: true
end
