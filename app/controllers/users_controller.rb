class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis
  end

  def downgrade
    @user = User.find(params[:id])
    # @user.role = 'standard'

    if @user.downgrade
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
      redirect_to :back
    end

    # @user_wikis = @user.wikis.where(private: true)
    #
    # @user_wikis.each do |public|
    #   public.update_attribute(private: false)
    # end
  end
end
