class RecipesController < ApplicationController
  def index
    @recipes = Recipe.search(params)

    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.includes(:ingredients).find_by(id: params[:id])
    render template: "recipes/show"
  end
end


