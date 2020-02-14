require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user){ FactoryBot.create :user }
  describe "Associations" do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:post_favorites).dependent(:destroy) }
    it { should have_many(:post_likes).through(:post_favorites).source(:post) }
    it { should belong_to(:identify_card).optional.dependent(:destroy) }
    it { should belong_to(:ward).optional }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:first_name)
      .is_at_most(Settings.name_maximum) }
    it { is_expected.to validate_length_of(:last_name)
      .is_at_most(Settings.name_maximum) }
    it { is_expected.to validate_length_of(:email)
      .is_at_most(Settings.email_maximum) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should have_secure_password }

    context "when email valid format" do
      it { should allow_value("tungpv@gmail.com").for(:email) }
    end

    context "when email invalid format" do
      before{ user.update_attributes(email: "tungpv@gmail") }
      it "Before save" do
        expect(user.errors[:email]).to be_present
      end
    end

    context "when first_name not presence" do
      it { should validate_presence_of(:first_name) }
    end
  end

  describe "Delegate" do
    attributes =
      %i(district_name province_name district province wards districts).freeze

    it { should delegate_method(:name).to(:ward).with_prefix(true).allow_nil }

    attributes.each do |attribute|
      it { should delegate_method(attribute).to(:ward).allow_nil }
    end
  end

  describe "Instance Method" do
    describe "#downcase_email" do
      let(:user){ FactoryBot.create :user }
      it "Before save" do
        expect(user.email).to eq(user.email.downcase)
      end
    end

    describe "#remember" do
      before{ user.remember }
      it "Updates success" do
        expect(user.remember_digest).to_not be_nil
      end
    end

    describe "#forget" do
      before{ user.forget }
      it "Updates success" do
        expect(user.remember_digest).to be_nil
      end
    end

    describe "#full_address" do
      before{ user.update_attributes(address: "abc", ward_id: 1) }
      it "After call full_address method" do
        expect(user.full_address).to \
          eq("abc - Phường Phúc Xá - Quận Ba Đình - Thành phố Hà Nội")
      end
    end

    describe "#authenticated?" do
      context "When authenticated true" do
        it do
          user.remember
          expect(user.authenticated? :remember, user.remember_token).to be true
          user.destroy
        end
      end

      context "When authenticated false" do
        it do
          expect(user.authenticated? :remember, user.remember_token).not_to be true
          user.destroy
        end
      end
    end
  end

  describe "Class Method" do
    describe ".digest" do
      it "After call digest method" do
        expect(User.digest "123456").not_to be_nil
      end
    end

    describe ".new_token" do
      it "After call new_token method" do
        expect(User.new_token).not_to be_nil
      end
    end
  end
end
