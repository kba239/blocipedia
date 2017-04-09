require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:wiki) { Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
    end
  end
end
