class RecipesController < ApplicationController
  def index
    query = params[:query] || ''
    offset = params[:offset] || 0

    # only returns matching ingredients with data - for all ingredients use .joins
    if params[:tags]
      tag_ids = params[:tags].split(',')
      @recipes = Recipe.includes(:ingredients, :tags)
      .where('recipes.name ILIKE :query OR ingredients.name ILIKE :query', query: "%#{query}%")
      .and(Tag.where(id: tag_ids))
      .group('recipes.id, ingredients.id, tags.id')
      .limit(20)
      .references(:ingredients, :tags)
      .order('recipes.id')
      .offset(offset)
    else
      @recipes = Recipe.includes(:ingredients, :tags)
      .where('recipes.name ILIKE :query OR ingredients.name ILIKE :query', query: "%#{query}%")
      .group('recipes.id, ingredients.id, tags.id')
      .limit(20)
      .references(:ingredients, :tags)
      .order('recipes.id')
      .offset(offset)
    end
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.includes(:ingredients).find_by(id: params[:id])
    render template: "recipes/show"
  end
end


