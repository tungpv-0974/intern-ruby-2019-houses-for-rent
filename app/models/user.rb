class User < ApplicationRecord
  USER_PARAMS = %i(first_name last_name email password password_confirmation).freeze

  has_many :posts, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_likes, through: :post_favorites, source: :post
  belongs_to :identify_card, optional: true, dependent: :destroy
  belongs_to :ward, optional: true

  before_save :downcase_email

  validates :password, presence: true, length: {minimum: Settings.pass_minimum},
    allow_nil: true
  validates :first_name, :last_name, presence: true,
    length: {maximum: Settings.name_maximum}
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: Settings.email_regex}, uniqueness: {case_sensitive: false}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
