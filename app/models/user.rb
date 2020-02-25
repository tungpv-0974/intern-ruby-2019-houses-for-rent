class User < ApplicationRecord
  USER_PARAMS =
    %i(first_name last_name email phone address ward_id birthdate avatar_url
      password password_confirmation).freeze

  has_many :posts, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_likes, through: :post_favorites, source: :post
  belongs_to :identify_card, optional: true, dependent: :destroy
  belongs_to :ward, optional: true

  attr_accessor :remember_token, :reset_token

  before_save :downcase_email

  mount_uploader :avatar_url, PictureUploader

  validates :password, presence: true, length: {minimum: Settings.pass_minimum},
    allow_nil: true
  validates :first_name, :last_name, presence: true,
    length: {maximum: Settings.name_maximum}, unless: -> { provider.present? }
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: Settings.email_regex}, uniqueness: {case_sensitive: false},
      unless: -> { provider.present? }

  has_secure_password

  delegate :name, to: :ward, prefix: true, allow_nil: true
  delegate :district_name, :province_name, :district, :province,
    :wards, :districts, to: :ward, allow_nil: true

  extend FriendlyId
  friendly_id :first_name, use: [:slugged, :finders]

  acts_as_url :first_name, url_attribute: :slug, sync: true, limit: Settings.url_limit

  def to_param
    "#{id}-#{slug}"
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def full_address
    return unless ward_name
    temp_address = [ward_name, district_name, province_name]
    temp_address.unshift(address) if address
    temp_address.join(" - ")
  end

  def post_favorites? post
    post_favorites.by_post(post.id).any?
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def from_omniauth auth

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.password = generate_unique_secure_token
        user.remote_avatar_url_url = auth.info.image
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save
      end
    end
  end

  private

  def downcase_email
    email.downcase! if email
  end
end
