class CreateHighlights < ActiveRecord::Migration[5.2]
  def change
    create_table :highlights do |t|
      t.text :text
      t.integer :index_in_article
      t.references :bookmark, foreign_key: true

      t.timestamps
    end
  end
end
