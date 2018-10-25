class RecipesController < ApplicationController

	def index
		@recipe = Recipe.all

	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		
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


	private

	def recipe_params
		params.require(:recipe).permit(
			:name,
			:description,
			:ingredients,
			:instructions,
			:posted_at
			)
	end


end
