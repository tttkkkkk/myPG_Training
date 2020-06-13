class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
      # @users = User.all
      @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    # 記事一覧
    @microposts = @user.microposts.paginate(page: params[:page])
    # 新規投稿用
    @micropost  = current_user.microposts.build
    # 参考URL（あれば登録
    @link = @micropost.links.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to mypgtraining!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # beforeアクション

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    # redirect_to(root_url) unless @user == current_user
    redirect_to(root_url) unless current_user?(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
