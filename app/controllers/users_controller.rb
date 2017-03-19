class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Blocipedia #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.visible_to(current_user)
  end

  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    if @user.save
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error creating your account. Please try again."
      redirect_to :back
    end

    @user_wikis = @user.wikis.where(private: true)

    @user_wikis.each do |public|
      public.update_attribute(private: false)
    end
  end
end
