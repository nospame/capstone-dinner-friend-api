class Recipe < ApplicationRecord
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :steps
  has_many :favorite_recipes

  def ingredients_list
    recipe_ingredients.map do |ri|
      "#{ri.prefix}#{ri.ingredient.name}#{ri.suffix}"
    end
  end

  def favorited?(current_user)
    FavoriteRecipe.exists?(
      user_id: current_user.id, 
      recipe_id: id) if current_user
  end

  def has_made?(current_user)
    FavoriteRecipe.find_by(
      user_id: current_user.id, 
      recipe_id: id).has_made if favorited?(current_user)
  end

  def self.search(params)
    whereables = [
      Whereable.new(
        valid: params[:q] ? true : false,
        where: Recipe.where("recipes.name ILIKE ?", "%#{params[:q]}%")
      ),
      Whereable.new(
        valid: params[:q] ? true : false,
        where: Recipe.where("ingredients.name ILIKE ?", "%#{params[:q]}%")
      )
    ]

    @recipes = Recipe
    .includes(:ingredients, :tags)
    .merge(whereables
      .select(&:valid)
      .map(&:where)
      .reduce(:or)
    )
    .references(:ingredients, :tags)
    .order("recipes.name #{params[:sort]}")

    if params[:tags]
      params[:tags].split(',').each do |tag|
        tag = Tag.find_by(name: tag)
        @recipes = @recipes.select{|recipe| recipe.tags.include?(tag)}
      end
    end

    @recipes = @recipes.slice(params[:offset].to_i || 0, 20)

    return @recipes
  end

end
