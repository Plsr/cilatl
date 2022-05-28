class CreatReaderView < ActiveRecord::Migration[6.1]
  def change
    create_table :reader_views do |t|
      t.text :content
      t.references :bookmark
    end
  end
end
