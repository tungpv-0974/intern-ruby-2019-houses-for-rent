class User < ApplicationRecord
  USER_PARAMS =
    %i(first_name last_name email password password_confirmation).freeze

  has_many :posts, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_likes, through: :post_favorites, source: :post
  belongs_to :identify_card, optional: true, dependent: :destroy
  belongs_to :ward, optional: true

  attr_accessor :remember_token, :reset_token

  before_save :downcase_email

  validates :password, presence: true, length: {minimum: Settings.pass_minimum},
    allow_nil: true
  validates :first_name, :last_name, presence: true,
    length: {maximum: Settings.name_maximum}
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: Settings.email_regex}, uniqueness: {case_sensitive: false}

  has_secure_password

  delegate :name, to: :ward, prefix: true, allow_nil: true
  delegate :district_name, :province_name, to: :ward, allow_nil: true

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
  end

  private

  def downcase_email
    email.downcase!
  end
end
