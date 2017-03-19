require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # # Shoulda tests for name
  # it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to validate_length_of(:name).is_at_least(1) }
  #
  # # Shoulda tests for email
  # it { is_expected.to validate_presence_of(:email) }
  # it { is_expected.to validate_uniqueness_of(:email) }
  # it { is_expected.to validate_length_of(:email).is_at_least(3) }
  #
  # # Shoulda tests for password
  # it { is_expected.to validate_presence_of(:password) }
  # it { is_expected.to have_secure_password }
  # it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    # it "should have name and email attributes" do
    #   expect(user).to have_attributes(name: user.name, email: user.email)
    # end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end
  end

  describe "roles" do
    it "account is standard by default" do
      expect(user.role).to eql("standard")
    end

    context "standard" do
      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end
    end

    context "premium user" do
      before do
        user.premium!
      end

      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end
    end
  end
end
