class AddDefaultFalseToFavoriteRecipesHasMade < ActiveRecord::Migration[7.0]
  def change
    change_column :favorite_recipes, :has_made, :boolean, default: false
  end
end
