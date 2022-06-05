source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use clearance for authentication
gem "clearance"

gem 'autoprefixer-rails'

# Use haml
gem "haml-rails", "~> 2.0"

# MetaInspector
gem 'metainspector'

gem 'webpacker', '~> 4'

gem 'gutentag', '~> 2.5'
gem 'grape', '~> 1.6.2'
gem 'grape-active_model_serializers'
gem 'rack-cors'
gem 'jwt'
gem 'delayed_job_active_record'

group :test do
  gem 'selenium-webdriver'
  gem 'database_cleaner-active_record'
  gem 'webmock'
  gem 'poltergeist'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.9'
  gem "factory_bot_rails", "~> 4.0"
  gem 'faker', '~> 2.5'
  gem 'dotenv-rails', '~> 2.7.5'
  gem 'capybara'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 4.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
