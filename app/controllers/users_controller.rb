class UsersController < ApplicationController
	skip_before_action :require_valid_user!
	before_action :reset_session

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:success] = "Account created. Sign in to continue."
			redirect_to login_path
		else
			flash[:error] = "User was not saved"
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(
			:first_name,
			:email,
			:password,
			:password_confirmation
			)
	end
end
