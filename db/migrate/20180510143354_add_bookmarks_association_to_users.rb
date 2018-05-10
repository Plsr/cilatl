class AddBookmarksAssociationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmarks, :user_id, :bigint, index: true
  end
end
