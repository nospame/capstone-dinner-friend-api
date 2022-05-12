class FavoriteIngredientsController < ApplicationController
  def index
    @favorite_ingredients = FavoriteIngredient.where(user_id: current_user.id)
    render template: 'favorite_ingredients/index'
  end

  def create
    @favorite_ingredient = FavoriteIngredient.new(
      user_id: current_user.id,
      ingredient_id: params[:ingredient_id]
    )
    @favorite_ingredient.save
    render template: 'favorite_ingredients/show'
  end

  def destroy
    favorite_ingredient = FavoriteIngredient.find_by(ingredient_id: params[:ingredient_id], user_id: current_user.id)
    favorite_ingredient.destroy
    render json: {message: "Ingredient removed."}
  end
end
