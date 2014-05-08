class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
  end

  def show
    @entry = Entry.find(params[:id])
    @user = User.find(@entry.user_id) unless @entry.nil?
    @comments = @entry.comments.paginate(page: params[:page], per_page: 10)
    @comment  = @entry.comments.build if signed_in?
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_back
      #redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @entry = Entry.find(params[:id])
    @user = User.find(@entry.user_id) unless @entry.nil?
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry updated"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def destroy
    @entry.destroy
    redirect_back
    #redirect_to root_url
  end
  
  private

    def entry_params
      params.require(:entry).permit(:title, :content)
    end
    
    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end