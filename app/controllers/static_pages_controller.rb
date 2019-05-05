class StaticPagesController < ApplicationController

  def home
    # 修正前
    # @micropost = current_user.microposts.build if logged_in?
    # 修正後
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def RoR
  end

  def JS
  end
end
