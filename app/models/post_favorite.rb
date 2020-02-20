class PostFavorite < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: {scope: :post_id}

  scope :by_post, ->(post_id){where(post_id: post_id)}
end
