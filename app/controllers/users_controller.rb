class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.where.not(id: current_user.id)
    # 変更
    @book = Book.new
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    #@userに関連付けされたやつを@booksに渡している
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user),alert:'warring!!'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have created book successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def create
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
