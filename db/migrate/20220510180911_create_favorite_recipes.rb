class CreateFavoriteRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_recipes do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.boolean :has_made

      t.timestamps
    end
  end
end
