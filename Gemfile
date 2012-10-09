source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem "paperclip"

gem "jquery-rails"

gem 'newrelic_rpm'
gem "airbrake"


# for better model names in urls
gem 'friendly_id'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'devise'


# to use Amazon S3 storage
gem "fog", "~> 1.3.1"

# rollout and degrade
# gem 'rollout'
# gem 'degrade'



# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
# gem 'capistrano-ext'
gem 'rvm-capistrano', :require => false
gem 'capistrano_colors'

group :development do

  # note that the route only exists in development
  # gem 'mailcatcher', :require => 'mail_catcher/web', :git => 'git://github.com/tuttinator/mailcatcher.git'

  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git', ref: 'bef0c494956e516540b7a9e72fa03be6576031dd'

  # find missing foreign keys
  gem 'immigrant'

  gem 'pry-rails'
  gem 'rails-sh', require: false

end


group :development, :test do

  gem 'rspec-rails'
  gem 'rails_best_practices'
  gem 'factory_girl_rails'

  gem 'capybara'

  gem 'faker', :git => "git://github.com/tuttinator/faker.git"

end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml-rails'
  gem 'eco'
  gem 'compass-rails'
  gem 'bootstrap-sass'

  gem 'uglifier', '>= 1.0.3'
end


# For image uploading
gem 'mini_magick'
gem 'carrierwave'

