class RenameUrltoLinkOnBookmarks < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookmarks, :url, :link
  end
end
