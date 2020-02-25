class PostFavorite < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum status: [:unseen, :seen, :inactive]

  validates :user_id, uniqueness: {scope: :post_id}

  scope :by_post, ->(post_id){where(post_id: post_id)}
  scope :order_by_create, ->{order created_at: :desc}

  after_create_commit :notification_broadcast_job

  private

  def notification_broadcast_job
    NotificationBroadcastJob.perform_later(PostFavorite.where(post_id: post.user.posts.pluck(:id)).unseen.count, self, post.user)
  end
end
