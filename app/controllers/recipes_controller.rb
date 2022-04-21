class RecipesController < ApplicationController
  def index
    if params[:query]
      # feels faster, but for each recipe, only puts out the matching ingredient
      # @recipes = Recipe.includes(:ingredients).where('recipes.name LIKE :query OR ingredients.name LIKE :query', query: "%#{params[:query]}%").references(:ingredients).limit(20)

      # feels slower, but gives the needed info
      @recipes = Recipe.joins(:ingredients).where('recipes.name LIKE :query OR ingredients.name LIKE :query', query: "%#{params[:query]}%").limit(20)
    else
      @recipes = Recipe.all.limit(20)
    end
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render template: "recipes/show"
  end
end


