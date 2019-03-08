class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result.includes(:articles).page(params[:page])
  end
  
  def search
    @q = Review.search(search_params)
    @reviews = @q.result(distinct: true)
  end
  
  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
        if @review.save
            flash[:success] = 'レビューが正常に投稿されました'
            redirect_to @review
        else
            @reviews = current_user.reviews.order('created_at DESC').page(params[:page])
            flash.now[:danger] = 'レビューが投稿されませんでした'
            render :new
        end
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.update(review_params)
        flash[:success] = "レビューは正常に更新されました"
        redirect_to @review
    else
        flash.now[:danger] = "レビューは更新されませんでした"
        render :edit
    end
  end

  def destroy
        @review.destroy
        flash[:success] = "レビューが正常に削除されました"
        redirect_to root_url
  end

  private  

  def review_params
          params.require(:review).permit(:content, :title, :genre, :score)
  end
  
  def correct_user
       @review = current_user.reviews.find_by(id: params[:id])
       unless @review
         flash[:danger] = "権限がありません"        
         redirect_to root_url
       end
  end
  
  def search_params
    params.require(:q).permit(:title_cont)
  end
end  