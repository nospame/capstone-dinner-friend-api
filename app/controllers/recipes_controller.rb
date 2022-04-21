class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render template: "recipes/index"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render template: "recipes/show"
  end
end
