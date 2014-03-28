source 'https://rubygems.org'

gem 'rails', '4.0.4'

gem 'sass-rails',   '~> 4.0.2'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.0.3'

gem 'therubyracer', platforms: :ruby

gem 'sqlite3', '~> 1.3.9'

gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 3.7.0'

gem 'jquery-rails', '~> 3.0.4'

group :development do
  gem 'rails-sh', require: false
  gem 'thin', '~> 1.6.2' 

  # for model annotation
  gem 'annotate', '~> 2.5.0'

  # for prettier errors
  gem 'better_errors', '~> 0.8.0'
  gem 'binding_of_caller', '~> 0.7.1'

  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano3-unicorn', '~> 0.1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
end

# Use unicorn as the app server
gem 'unicorn', '~> 4.8.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# better debugging with pry
gem 'pry', '~> 0.9.12.6'