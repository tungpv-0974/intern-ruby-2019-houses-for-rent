require 'rails_helper'

RSpec.describe Province, type: :model do
  describe "Associations" do
    it { should have_many(:districts).dependent(:destroy) }
  end
end
