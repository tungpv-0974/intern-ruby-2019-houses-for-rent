class Ward < ApplicationRecord
  belongs_to :district
  has_many :posts
  has_many :users

  delegate :name, to: :district, prefix: true
  delegate :province_name, :province, :wards, :districts, to: :district
end
