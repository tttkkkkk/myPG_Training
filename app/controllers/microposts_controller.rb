class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def create
    @micropost = current_user.microposts.build(strong_params)
    if @micropost.save!
      # flash[:success] = "Micropost created!"
      redirect_to current_user
    else
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

  def show
    @micropost = Micropost.find(params[:id])
    @category = Category.find(@micropost.category_id)
  end

  private
    def strong_params
      # params.require(:micropost).permit(:content)
      params.require(:micropost).permit(:category_id,:content,:title,:code)
    end
    def search_params
      # params.require(:micropost).permit(:content)
      params.require(:micropost).permit(:category_id,:content,:title,:code)
    end

end

