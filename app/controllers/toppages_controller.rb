class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = User.find_by(id: params[:id])
      @reviews = Review.order(created_at: :desc).page(params[:page])
    else
      @user = nil
    end  
  end
end
