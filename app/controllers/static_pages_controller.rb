require 'csv'
require 'kconv'

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

  def download    
    @microposts = Micropost.where(user: current_user)
    headers = Micropost::CSV_EXPORT_HEADER
    microposts = []
    @microposts.each do |micropost|
      microposts << micropost
    end
    send_csv_data headers, microposts
  end

  # CSVファイルをダウンロード
  def send_csv_data(header, records)
    csv_string = CSV.generate do |csv|
      csv<< header
      records.each do |record|
        csv<< record.to_export_row  rescue nil
      end
    end.tosjis

    send_data(csv_string,
      :type => "text/csv; charset=shift_jis",
      :filename => "#{Time.now.strftime('%Y%m%d-%H%M')}.csv")
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
