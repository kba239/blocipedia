require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}

  describe "GET show" do
    it "returns http success" do
      get :show, {id: user.id}
      expect(response).to have_http_status(302)
    end

    it "renders the #show view" do
      get :show, {id: user.id}
      expect(response).to render_template :show
    end
  end

  describe "PUT downgrade" do
    it "downgrades user from premium to standard" do
      user.role = :premium
      put :downgrade, {user: user.id}
      expect(assigns(:user)).to eq(standard)
    end

    it "makes private wikis public" do
      user.role = :premium
      put :downgrade, {user: user.id}
      u=assigns(user)
      #work on line below
      expect(assigns(user.wikis)).to eq(public)
    end
  end
end
