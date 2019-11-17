class RemoveMediaTypesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :media_types
  end
end
