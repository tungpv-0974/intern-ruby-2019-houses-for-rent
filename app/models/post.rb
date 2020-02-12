class Post < ApplicationRecord
  POST_PARAMS = %i(title content total_bathroom total_bedroom area price
    house_type user_id address ward_id).freeze
  POST_PICTURE_PARAMS = %i(id title image_url post_id).freeze

  enum house_type: {apartment: 0, motel_room: 1}

  belongs_to :user
  has_many :post_pictures, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :like_users, through: :post_favorites, source: :user
  belongs_to :ward, optional: true

  validates :user_id, :ward_id, :title, :content, :total_bathroom,
    :total_bedroom, :price, :house_type, :address, presence: true
  validates :total_bathroom, :total_bedroom,
    numericality: {only_integer: true,
                   greater_than_or_equal_to: Settings.total_room_min,
                   less_than: Settings.total_room_max}

  scope :order_by_created_desc, ->{order(created_at: :desc)}
  scope :by_ward, ->(ward_id){where(ward_id: ward_id) if ward_id.present?}
  scope :by_price, ->(price_min, price_max){where(price: price_min..price_max)}
  scope :by_area, ->(area_min, area_max){where(area: area_min..area_max)}
  scope :by_district, ->(district_id) do
    return unless district_id.present?
    where(ward_id: District.find_by(id: district_id).ward_ids)
  end
  scope :by_province, ->(province_id) do
    return unless province_id.present?
    where(ward_id: Province.find_by(id: province_id).ward_ids)
  end

  delegate :name, to: :ward, prefix: true, allow_nil: true
  delegate :district_name, :province_name, :district, :province,
    :wards, :districts, to: :ward, allow_nil: true
  delegate :first_name, to: :user, prefix: true
  delegate :first, to: :post_pictures, prefix: :image

  accepts_nested_attributes_for :post_pictures

  def post_baner
    default = Settings.avatar_default
    post_pictures.empty? ? default : image_first.image_url.url
  end

  def self.search_post params
    by_province(params[:province])
      .by_district(params[:district])
      .by_ward(params[:post][:ward_id])
      .by_area(params[:area_range]
          .split("\;")[0], params[:area_range].split("\;")[1])
      .by_price(params[:price_range]
          .split("\;")[0], params[:price_range].split("\;")[1])
  end
end
