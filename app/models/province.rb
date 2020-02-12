class Province < ApplicationRecord
  has_many :districts, dependent: :destroy

  def ward_ids
    districts.includes(:wards).map do |district|
      district.wards.pluck(:id)
    end.flatten
  end
end
