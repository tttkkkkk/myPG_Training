class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def show
    @micropost = Micropost.find(params[:id])
    @category = Category.find(@micropost.category_id)
  end


  private

    def micropost_params
      # params.require(:micropost).permit(:content)
      params.require(:micropost).permit(:content,:title,:code)
    end

end
