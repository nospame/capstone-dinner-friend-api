class RenameFavoriteIngredientsToFavoriteSearches < ActiveRecord::Migration[7.0]
  def change
    rename_table :favorite_ingredients, :favorite_searches
    remove_column :favorite_searches, :ingredient_id, :integer
    add_column :favorite_searches, :search_term, :string
  end
end
