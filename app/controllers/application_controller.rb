class ApplicationController < ActionController::Base
protect_from_forgery with: :exception

  include SessionsHelper

  private
  
  #def counts(user)
    #@count_reviews = user.reviews.count
    #@count_like_reviews = user.like_reviews.count
    #@count_stock_reviews = user.stock_reviews.count
  #end

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
