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

  Whereable = Struct.new(
    :valid,
    :where,
    keyword_init: true
  )

  def self.search(params)
    whereables_or = [
      Whereable.new(
        valid: params[:q] ? true : false,
        where: Recipe.where("recipes.name ILIKE ?", "%#{params[:q]}%")
      ),
      Whereable.new(
        valid: params[:i] ? true : false,
        where: Recipe.where("ingredients.name ILIKE ?", "%#{params[:i]}%")
      )
    ]
    whereables_and = [
      Whereable.new(
        valid: params[:tags] ? true : false,
        where: Recipe.where("tags.name LIKE ?", "%#{params[:tags]}%")
      )
    ]

    Recipe
    .includes(:ingredients, :tags)
    .merge(whereables_or
      .select(&:valid)
      .map(&:where)
      .reduce(:or)
    )
    .merge(whereables_and
      .select(&:valid)
      .map(&:where)
      .reduce(:and))
    .references(:ingredients)
    .limit(20)
    .offset(params[:offset])
  end
end
