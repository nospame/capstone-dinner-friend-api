class RecipesController < ApplicationController
  def index
    if params[:query]
      # only returns matching ingredients with data - for all ingredients use .joins
      @recipes = Recipe.includes(:ingredients, :tags)
      .where('recipes.name LIKE :query OR ingredients.name LIKE :query', query: "%#{params[:query]}%")
      .distinct.limit(20).references(:ingredients, :tags)
    else
      @recipes = Recipe.includes(:ingredients, :tags).all.limit(20)
    end
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render template: "recipes/show"
  end
end


