class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]

  def create
    begin
      ActiveRecord::Base::transaction do
        @micropost = Micropost.new(strong_params.merge!(user: current_user))
        if @micropost.save
          @link = Link.new(link_params.merge!(micropost: @micropost))
          @link.save
          flash[:success] = 'create!'
          redirect_to current_user
        else
          @user = current_user
          @feed_items = current_user.feed.paginate(page: params[:page])
          render("users/show")
        end
      end
    rescue => e
      Rails.logger.error( e.message )
      Rails.logger.error( e.backtrace.join("\n") )
      redirect_to current_user
    end
  end

  def index
  end

  def show
    @micropost = Micropost.find(params[:id])
    @links = @micropost.links
    @category = Category.find(@micropost.category_id)
  end

  def upd_add
    @micropost = Micropost.find(params[:id])
    @micropost.update_column(:check, @micropost.check + 1)

    #TODO　一旦保留（再表示したい感じ）
    # @links = @micropost.links
    # @category = Category.find(@micropost.category_id)
    # redirect_to :show
    # render action: :show
    # render("microposts/show")
    # redirect_to :show
  end

  def upd_mns
    micropost = Micropost.find(params[:id])
    micropost.update_column(:check, micropost.check - 1)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy!
    flash[:success] = 'delete!'
    redirect_to current_user
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    begin
      @micropost = Micropost.find(params[:id])
      @micropost.attributes = strong_params
      @micropost.save!
      flash[:success] = 'update!'
      redirect_to current_user
    rescue => e
      Rails.logger.error( e.message )
      Rails.logger.error( e.backtrace.join("\n") )
      render :edit
    end
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

