class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def create
    begin
      ActiveRecord::Base::transaction do      
        @micropost = Micropost.new(strong_params.merge!(user: current_user))
        @micropost.save!
        @link = Link.new(link_params.merge!(micropost: @micropost))
        @link.save!
        redirect_to current_user      
      end
    rescue => e
      Rails.logger.error( e.message )
      Rails.logger.error( e.backtrace.join("\n") )
      render current_user
    end
  end

  def upd_add
    micropost = Micropost.find(params[:id])
    micropost.update_column(:check, micropost.check + 1)
  end

  def upd_mns
    micropost = Micropost.find(params[:id])
    micropost.update_column(:check, micropost.check - 1)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy!
    redirect_to current_user
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    @micropost.attributes = strong_params
    @micropost.save!
    redirect_to current_user      
  end

  def show
    @micropost = Micropost.find(params[:id])
    @links = @micropost.links
    @category = Category.find(@micropost.category_id)
  end

  private
    def strong_params
      params.require(:micropost).permit(:category_id,:content,:title,:code, :image)
    end
    def link_params
      params.require(:link).permit(:url)
    end
    def search_params
      params.require(:micropost).permit(:category_id,:content,:title,:code)
    end

end

