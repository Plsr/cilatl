class RemoveFieldsFromBookmarks < ActiveRecord::Migration[5.2]
  def change
    change_table :bookmarks do |t|
      t.remove :fields
    end
  end
end
