require 'csv'

table = CSV.parse(File.read("first_1000_recipes.csv"), headers: true)
table.each do |row|
  # create the recipe with independent attributes
  recipe = Recipe.create!(
    name: row["name"],
    description: row["description"],
    servings: row["servings"].to_i
  )

  steps = row["steps"].delete("[]").delete_prefix("'").delete_suffix("'").split("\', \'")
  steps.each do |step|
    Step.create!(
      description: step,
      recipe_id: recipe.id
    )
  end
  
  #split the tags
  tags = row["search_terms"].delete("{}'").split(', ')

  #create a new Tag entry for each tag that doesn't already exist
  tags.each do |t|
    tag = Tag.find_by(name: t) || Tag.create!(name: t)

    #create recipe_tags to associate
    RecipeTag.create!(
      recipe_id: recipe.id,
      tag_id: tag.id
    )
  end

  #split the ingredients
  ingredients = row["ingredients"].delete("[]'").split(', ')

  #split the ingredient details to end up with formatted details
  ingredient_details = row["ingredients_raw_str"].split("\",\"")
  ingredient_details.each do |detail|
    detail.delete!("[]'\"")
    detail.squeeze!(" ")
  end

  #format looks like {name: 'water', prefix: '4 cups ', suffix: ''}
  formatted_details = []
  ingredients.each do |ingredient|
    selected_details = ingredient_details.select{|i_d| i_d.include?(ingredient)}
    formatted_details += selected_details.map do |s_d|
      {name: ingredient, prefix: s_d.split("#{ingredient}")[0], suffix: s_d.split("#{ingredient}")[1]}
    end
  end
 
  #create a new Ingredient entry for each ingredient that doesn't exist
  formatted_details.each do |f_d|
    ingredient = Ingredient.find_by(name: f_d[:name]) || Ingredient.create!(name: f_d[:name])

    #recipe_ingredients to associate
    RecipeIngredient.create!(
      recipe_id: recipe.id,
      ingredient_id: ingredient.id,
      prefix: f_d[:prefix],
      suffix: f_d[:suffix]
    )
  end
  p "#{recipe.name} added"
end






# p ingredients
# p ingredient_details
# steps

# get the prefix and suffix out of ingredient details, based on ingredients
# for each ingredient, find ingredient details that include it - split the matching details based on ingredient name
# make the prefix anything before the name, suffix anything after

# ingredient_details ultimately: [{name: 'water', prefix: '4 cups', suffix: ''}, ]
# what's the difference between 'tags' and 'search terms' in this dataset?

# find and replace in CSV
# clean &amp; (&) &quot; (") from recipe name
# clean %26 (&) and %2c (,) from ingredients
# clean \u003d (=) from ingredients_raw_str
# \u0027 (')
# \u003c (<)
# %27 (')