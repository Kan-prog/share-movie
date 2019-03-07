class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = User.find_by(id: current_user.id)
    else
      @user = nil
    end  
  end
end
