class CreateJoinTableBookmarkField < ActiveRecord::Migration[5.1]
  def change
    create_join_table :bookmarks, :fields do |t|
      t.index [:bookmark_id, :field_id]
    end
  end
end
