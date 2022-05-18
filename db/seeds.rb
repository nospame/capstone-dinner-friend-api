require 'csv'

table = CSV.parse(File.read("200_recipes.csv"), headers: true)
table.each do |row|
  # create the recipe with independent attributes
  recipe = Recipe.create!(
    name: CGI::unescapeHTML(row["name"]).gsub("\\u00", "%").squeeze(' ').titleize,
    description: CGI::unescapeHTML(row["description"] || ''),
    servings: row["servings"].to_i
  )

  # split and create the steps
  steps = row["steps"].delete("[]").delete_prefix("'").delete_suffix("'").split("\', \'")
  steps.each do |step|
    Step.create!(
      description: CGI::unescapeHTML(step),
      recipe_id: recipe.id
    )
  end
  
  # split tags
  tags = row["search_terms"].delete("{}'").split(', ')

  # create each tag if needed
  tags.each do |t|
      tag = Tag.find_or_create_by(name: t)

      # create recipe_tags to associate
      RecipeTag.create!(
        recipe_id: recipe.id,
        tag_id: tag.id
      )
  end

  # split the ingredients
  ingredients = row["ingredients"].delete("[]'").split(', ')

  # split the ingredient details to end up with formatted details
  ingredient_details = CGI::unescape(row["ingredients_raw_str"].gsub("\\u00", "%")).split("\",\"")
  ingredient_details.each do |detail|
    detail.delete!("[]'\"")
    detail.squeeze!(' ')
  end

  # format the details for each ingredient
  formatted_details = []
  ingredients.each do |ingredient|

    # select the details containing this ingredient as there may be more than one
    selected_details = ingredient_details.select{|i_d| i_d.include?(ingredient)}

    # format details as {name: 'ingredient', prefix: 'some quantity', suffix: 'some preparation'}
    formatted_details += selected_details.map do |s_d|
      {name: ingredient, prefix: s_d.split("#{ingredient}")[0], suffix: s_d.split("#{ingredient}")[1]}
    end
  end
 
  # create each ingredient if needed
  formatted_details.each do |f_d|
    ingredient = Ingredient.find_or_create_by(name: f_d[:name])

    # create recipe_ingredients to associate
    RecipeIngredient.create!(
      recipe_id: recipe.id,
      ingredient_id: ingredient.id,
      prefix: f_d[:prefix],
      suffix: f_d[:suffix]
    )
  end
  p "#{recipe.name} created"
end
