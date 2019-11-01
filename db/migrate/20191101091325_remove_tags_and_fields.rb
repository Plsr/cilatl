class RemoveTagsAndFields < ActiveRecord::Migration[5.2]
  def change
    drop_table :tags
    drop_table :fields
    drop_table :bookmarks_fields
    drop_table :bookmarks_tags
  end
end
