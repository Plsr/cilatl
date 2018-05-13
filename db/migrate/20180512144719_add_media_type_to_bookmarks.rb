class AddMediaTypeToBookmarks < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookmarks, :media_type
    add_reference :bookmarks, :media_type, index: true
  end
end
