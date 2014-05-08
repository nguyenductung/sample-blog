class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :following_user, only: :create
 
  def index
  end
  
  def create
    #@comment = current_user.comments.build(comment_params)
    @comment = Comment.create(content: comment_params[:content], entry_id: comment_params[:entry_id], user_id: comment_params[:user_id])
    if @comment.save
      flash[:success] = "Comment posted!"
      redirect_back
    else
      #@feed_items = []
      #render entry_path, id: comment_params[:entry_id]
      @entry = Entry.find(comment_params[:entry_id])
      @comments = @entry.comments.paginate(page: params[:page], per_page: 10) unless @entry.nil?
      render 'entries/show'
    end
  end
  
  def destroy
    @comment.destroy
    redirect_back
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id, :user_id)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
    
    def following_user
      
    end
end