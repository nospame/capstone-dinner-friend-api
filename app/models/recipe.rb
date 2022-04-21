class Recipe < ApplicationRecord
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :steps

  def ingredients_list
    recipe_ingredients.map do |ri|
      "#{ri.prefix}#{ri.ingredient.name}#{ri.suffix}"
    end
  end

end
