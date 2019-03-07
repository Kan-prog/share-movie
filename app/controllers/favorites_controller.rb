class FavoritesController < ApplicationController
  def create
    @review = Review.find_by(id: params[:review_id])
    
    if params[:type] == "Like"
      current_user.like(@review)
      flash[:success] = "共感しました。"
    elsif params[:type] == "Stock"
      current_user.stock(@review)
      flash[:success] = "気になる！に登録しました。"
    end 
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @review = Review.find_by(id: params[:review_id])
    
    if params[:type] == "Like"
      current_user.unlike(@review)
      flash[:success] = "共感を解除しました。"
    elsif params[:type] == "Stock"
      current_user.unstock(@review)
      flash[:success] = "気になる！を解除しました。"
    end
    
    redirect_back(fallback_location: root_path)
  end
end
