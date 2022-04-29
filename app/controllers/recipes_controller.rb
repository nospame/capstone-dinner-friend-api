class RecipesController < ApplicationController
  def index
    query = params[:query] || ''
    offset = params[:offset] || 0
    # only returns matching ingredients with data - for all ingredients use .joins
    @recipes = Recipe.includes(:ingredients, :tags)
      .where('recipes.name ILIKE :query OR ingredients.name ILIKE :query', query: "%#{query}%")
      .limit(20)
      .references(:ingredients, :tags)
      .order('recipes.id')
      .offset(offset)
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.includes(:ingredients).find_by(id: params[:id])
    render template: "recipes/show"
  end
end


