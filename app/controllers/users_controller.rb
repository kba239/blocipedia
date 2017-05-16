class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis
  end

  def downgrade
    @user = User.find(params[:id])

    if @user.downgrade
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to wiki_path
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
      redirect_to :back
    end
  end
end
