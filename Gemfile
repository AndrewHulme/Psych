source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/AndrewHulme/Psych.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem "puma", "~> 4.3.5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.3', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# gem "devise", "~> 4.7"
# gem "devise-jwt", "~> 0.6"
# gem "fog-aws"
# gem "graphiql-rails"
gem "graphql", "~> 1.9"
# gem "graphql-errors", "~> 0.3"
# gem "rails_admin", "~> 2.0"
gem "sidekiq"


group :development, :test do
  gem "brakeman", "~> 4.9", require: false
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug", "~> 1.3.3"
  gem "rspec-rails"
  gem "rubocop", "~> 0.85.1", require: false
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "annotate"
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "pry-rails"
  gem "pry-remote"
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "rspec-sidekiq", "~> 3.0", ">= 3.0.3"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  # gem "timecop"
  gem "webmock", "~> 3.7"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
