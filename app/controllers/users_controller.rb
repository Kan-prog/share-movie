class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :like_reviews, :stocks_reviews]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find_by(id: params[:id])
    @reviews = @user.reviews.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
   
    if current_user == @user
   
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        render :show
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end   
     
    else
        redirect_to root_url
    end
  end
  
  def like_reviews
    @user = User.find_by(id: params[:id])
    @like_reviews = @user.like_reviews.page(params[:page])
    counts(@user)
  end
  
  def stock_reviews
    @user = User.find_by(id: params[:id])
    @stock_reviews = @user.stock_reviews.page(params[:page])
    counts(@user)
  end
  
  private
  
    #ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def correct_user
      @user = User.find_by(id: params[:id])
      unless @user == current_user
        flash[:danger] = "権限がありません" 
        redirect_to user_path
      end  
  end
end
