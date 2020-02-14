require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:ward).optional }
    it { should have_many(:post_pictures).dependent(:destroy) }
    it { should have_many(:post_favorites).dependent(:destroy) }
    it { should have_many(:like_users).through(:post_favorites).source(:user) }
  end

  describe "Validations" do
    attributes =
      %i(user_id ward_id title content total_bathroom total_bedroom price
        house_type address).freeze

    attributes.each do |attribute|
      it { is_expected.to validate_presence_of(attribute)}
    end

    it "numericality_of total_bathroom" do
      should validate_numericality_of(:total_bathroom).only_integer \
      .is_greater_than_or_equal_to(Settings.total_room_min) \
      .is_less_than(Settings.total_room_max)
    end
    it "numericality_of total_bedroom" do
      should validate_numericality_of(:total_bedroom).only_integer \
      .is_greater_than_or_equal_to(Settings.total_room_min) \
      .is_less_than(Settings.total_room_max)
    end
  end

  describe "Delegate" do
    attributes =
      %i(district_name province_name district province wards districts).freeze

    attributes.each do |attribute|
      it { should delegate_method(attribute).to(:ward).allow_nil }
    end

    it { should delegate_method(:name).to(:ward).with_prefix(true).allow_nil }
    it { should delegate_method(:first).to(:post_pictures).with_prefix(:image) }
  end

  describe "Accepts nested attributes fo" do
    it { should accept_nested_attributes_for(:post_pictures) }
  end
end
