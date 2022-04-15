class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.string :prefix
      t.string :suffix

      t.timestamps
    end
  end
end
