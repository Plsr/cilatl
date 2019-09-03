namespace :media_types do
  desc "Create initial media types on clean database"
  task generate_initial: :environment do
    media_type_names = %w[Article Song Video]

    media_type_names.each do |name|
      if MediaType.create(name: name)
        puts "Created MediaType #{name}"
      else
        puts "Could not create MediaType #{name}"
      end
    end
  end
end
