class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render template: "recipes/index"
  end
end
