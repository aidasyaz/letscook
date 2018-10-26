class RecipesController < ApplicationController

	def index
		# for pagination on recipe#index page
		@recipe = Recipe.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user_id = current_user.id
		if @recipe.save
			flash[:success] = "recipe saved"
			redirect_to root_path
		else
			flash[:error] = "recipe not saved. Try again."
			render 'new'
		end
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
 		@recipe = Recipe.find(params[:id])

 		if @recipe.update(recipe_params)
 			flash[:success] = "You have successfully edited recipe!"
			redirect_to recipe_path(@recipe.id)
 		else
 			flash[:error] = "Recipe couldnt be edited. Try again."
 			redirect_to edit_recipe_path(@recipe.id)
 		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy

		redirect_to root_path
	end


	private

	def recipe_params
		params.require(:recipe).permit(
			:image,
			:remove_image,
			:name,
			:description,
			:ingredients,
			:instructions,
			:posted_at
			)
	end


end
