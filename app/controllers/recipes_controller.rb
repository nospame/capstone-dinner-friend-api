class RecipesController < ApplicationController
  def index
    if params[:query]
      # Recipes that include ingredients which match either: the ingredient's recipe's name or the ingredient's name
      @recipes = Recipe.includes(:ingredients).where('recipes.name LIKE :query or ingredients.name LIKE :query', query: "%#{params[:query]}%").references(:ingredients)
    else
      @recipes = Recipe.all
    end
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render template: "recipes/show"
  end
end


