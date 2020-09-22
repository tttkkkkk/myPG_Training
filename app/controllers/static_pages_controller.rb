class StaticPagesController < ApplicationController

  def home
    @microposts = Micropost.where(user: current_user)
    @microposts = @microposts.joins(:category).order(updated_at: "desc").limit(7)
  end

  def help
    puts "** help **"
  end

  def RoR
    puts "** RoR **"
  end

  #カテゴリID で検索
  #__method__ でメソッド名が取得可
  def js
    search(1)
  end
  def jquery
    search(3)
  end
  def rails
    search(3)
  end
  def ruby
    search(4)
  end
  def sitemap
    search()
  end

  private
   def search(id = nil)
     if id
      @category = Category.find_by_id(id)
      @microposts = Micropost.where(category: @category)
     else
      @q = Micropost.ransack(params[:q])
      @microposts = @q.result(distinct: true).page(params[:page])
    end
   end


end
