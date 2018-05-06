class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :description
      t.string :media_type, null: false
      t.string :fields, array: true, default: [], null: false

      t.timestamps
    end
  end
end
