class SessionsController < ApplicationController
  skip_before_action :require_valid_user!, except: [:destroy]

  # google omniauth
  def create_from_omniauth
  auth_hash = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = root_path
      @notice = "User created. Please confirm or edit details"
    end

    session[:user_id] = user.id
    redirect_to @next, :notice => @notice
  end

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
    params.require(:session).permit(
      :name,
      :email,
      :password
      )
  end



end
