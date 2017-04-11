require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}
  before(:each) do
    sign_in user
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: user.id}
      expect(response).to render_template :show
    end
  end

  describe "PUT downgrade" do
    it "downgrades user from premium to standard" do
      user.premium!
      put :downgrade, {id: user.id}
      u=assigns(:user)
      expect(u.role).to eq('standard')
      expect(u.standard?).to eq true
    end

    it "makes private wikis public" do
      user.premium!
      put :downgrade, {id: user.id}
      u=assigns(:user)
      u.wikis.each do |wiki|
        expect(wiki.public?).to eq true
      end
    end
  end
end
