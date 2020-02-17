require 'rails_helper'

RSpec.describe District, type: :model do
  describe "Associations" do
    it { should have_many(:wards).dependent(:destroy) }
    it { should belong_to(:province) }
  end

  describe "Delegate" do
    it { should delegate_method(:name).to(:province).with_prefix(true) }
    it { should delegate_method(:districts).to(:province) }
  end
end
