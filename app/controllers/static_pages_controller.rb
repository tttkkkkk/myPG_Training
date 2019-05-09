class StaticPagesController < ApplicationController

  def home
    # @micropost  = current_user.microposts.build
    # @feed_items = current_user.feed.paginate(page: params[:page])
    puts "** home **"
    @microposts = Micropost.all
    if @microposts.any?
      puts "** ok home **"
    elsif
      puts  @microposts.count
      puts "** ng  home **"
    end

  end

  def help
    puts "** help **"
  end

  def RoR
    puts "** RoR **"
  end

  def js
    puts "** JS **"
    @microposts = Micropost.all
    if @microposts.any?
      puts "** ok home **"
    elsif
      puts  @microposts.count
      puts "** ng  home **"
    end
  end
end
