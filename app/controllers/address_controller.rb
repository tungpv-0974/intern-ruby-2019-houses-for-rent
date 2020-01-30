class AddressController < ApplicationController
  before_action :load_province, only: :districts
  before_action :load_district, only: :wards

  def districts
    @districts = @province.districts.pluck(:name, :id).to_a
  end

  def wards
    @wards = @district.wards.pluck(:name, :id).to_a
  end
end
