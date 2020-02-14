require 'rails_helper'

RSpec.describe Ward, type: :model do
  describe "Associations" do
    it { should have_many(:posts) }
    it { should have_many(:users) }
    it { should belong_to(:district) }
  end

  describe "Delegate" do
    attributes = %i(province_name province wards districts).freeze

    it { should delegate_method(:name).to(:district).with_prefix(true) }
    attributes.each do |attribute|
      it { should delegate_method(attribute).to(:district) }
    end
  end
end
