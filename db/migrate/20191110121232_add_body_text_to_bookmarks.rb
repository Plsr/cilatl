class AddBodyTextToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :body_text, :text
  end
end
