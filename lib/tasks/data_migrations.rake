namespace :data_migrations do
  desc 'Copy existing fields to tags and update the bookmarks accordingly'
  task fields_to_tags: :environment do
    field_names = Field.all.pluck(:name)
    field_names.map { |name| Tag.create(name: name) }

    Bookmark.all.map do |bookmark|
      bookmark.fields.map do |field|
        corresponding_tag = Tag.find_by(name: field.name)
        bookmark.tags << corresponding_tag
      end
    end
  end
end
