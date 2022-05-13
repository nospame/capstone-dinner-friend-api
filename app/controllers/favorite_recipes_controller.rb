class FavoriteRecipesController < ApplicationController
  before_action :authenticate_user

  def index
    @favorite_recipes = FavoriteRecipe.where(user_id: current_user.id).order('created_at DESC')
    render template: 'favorite_recipes/index'
  end

  def create
    @favorite_recipe = FavoriteRecipe.find_or_create_by(
      user_id: current_user.id,
      recipe_id: params[:recipe_id]
    )
    render template: 'favorite_recipes/show'
  end

  def update
    @favorite_recipe = FavoriteRecipe.find_by(recipe_id: params[:recipe_id], user_id: current_user.id)
    @favorite_recipe.has_made = params[:has_made]
    @favorite_recipe.save
    render template: 'favorite_recipes/show'
  end

  def destroy
    favorite_recipe = FavoriteRecipe.find_by(recipe_id: params[:recipe_id], user_id: current_user.id)
    favorite_recipe.destroy
    render json: {message: "Favorite removed."}
  end
end
