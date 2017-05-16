class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.all
    @wikis = Wiki.visible_to(current_user)

    if current_user.premium? || current_user.admin?
      @wikis = Wiki.all
    end
  end

  def show
     @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
      end
    end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
     @wiki = Wiki.find(params[:id])
     @wiki.assign_attributes(wiki_params)

     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  def add_collaborator
    @wiki = Wiki.find(params[:id])
    candidate = User.find_by(email: params[:email])
    @wiki.collaborators.each do |collaborator|
      if collaborator.email == candidate.email
        flash[:alert] = "That user is already a collaborator for the wiki."
        redirect_to wiki_path(@wiki)
        return
      end
    end
    if candidate.email == @wiki.user.email
      flash[:alert] = "That user is the owner of the wiki."
    else
      @wiki.collaborators << candidate
    end
    redirect_to wiki_path(@wiki)
  end

  def delete_collaborator
    @wiki = Wiki.find(params[:id])
    candidate_id = params[:user_id]
    exists = @wiki.collaborators.pluck(:id).include?(candidate_id.to_i)
    if exists
      candidate = User.find(candidate_id)
      @wiki.collaborators.delete(candidate)
      flash[:alert] = "That collaborator was removed."
    else
      flash[:alert] = "That user is not a collaborator for the wiki."
    end
    redirect_to wiki_path(@wiki)
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaborators)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end
end
