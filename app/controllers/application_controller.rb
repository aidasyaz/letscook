class ApplicationController < ActionController::Base
before_action :require_valid_user!

  def current_user
  	# user logged or not
    if !session[:user_id].blank?
      @user ||= User.find(session[:user_id])
    end
  end

  def require_valid_user!
  	# user not logged 
    if current_user.nil?
      flash[:error] = 'You must be logged in to access that page!'
      redirect_to login_path
    end
  end

end
