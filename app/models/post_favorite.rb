class PostFavorite < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: {scope: :post_id}

  after_create_commit -> { NotificationBroadcastJob.perform_later(PostFavorite.count, self)}

  scope :by_post, ->(post_id){where(post_id: post_id)}
end
