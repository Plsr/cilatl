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

  desc 'Create reader view for bookmarks where non is present yet'
  task create_reader_views: :environment do
    Bookmark.all.each do |bookmark|
      next if bookmark.reader_view&.content&.present?

      pp "Creating reader view for bookmark #{bookmark.id}"
      bookmark.create_reader_view!(content: bookmark.body_text)
    end
  end
end
