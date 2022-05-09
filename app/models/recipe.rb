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

  def includes_tag?(tag)
    # RecipeTag.exists?(recipe_id: id, tag_id: tag.to_i)
  end

  def self.search(params)
    whereables_or = [
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
    .merge(whereables_or
      .select(&:valid)
      .map(&:where)
      .reduce(:or)
    )
    .references(:ingredients, :tags)
    # .limit(20)
    .offset(params[:offset])

    params[:tags].split(',').each do |tag|
      @recipes = @recipes.select{|recipe| recipe.tags.include?(Tag.find_by(name: tag))}
    end

    # @recipes = @recipes.limit(20)

    return @recipes
  end

end
