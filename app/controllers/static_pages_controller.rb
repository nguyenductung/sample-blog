class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @entry = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 3)
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
