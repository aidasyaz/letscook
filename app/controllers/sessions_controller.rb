class SessionsController < ApplicationController
  skip_before_action :require_valid_user!, except: [:destroy]

  def new
  end

  def create
  	# resets user sessions
  	reset_session
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
    # logs user in if user exist and allowed to authenticate
      session[:user_id] = @user.id
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
    # if email or password incorrect
      flash[:error] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
  	# for logging out, resets user session
  	reset_session
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
