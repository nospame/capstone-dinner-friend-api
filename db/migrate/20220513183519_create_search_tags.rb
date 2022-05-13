class CreateSearchTags < ActiveRecord::Migration[7.0]
  def change
    create_table :search_tags do |t|
      t.integer :tag_id
      t.integer :favorite_search_id

      t.timestamps
    end
  end
end
