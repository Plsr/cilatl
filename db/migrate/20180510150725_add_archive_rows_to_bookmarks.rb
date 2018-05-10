class AddArchiveRowsToBookmarks < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmarks, :archived, :boolean, null: false, default: false
    add_column :bookmarks, :archived_on, :datetime
  end
end
