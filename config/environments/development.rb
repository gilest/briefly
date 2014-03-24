Briefly::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.eager_load = false

# 
#   ActionMailer::Base.smtp_settings = {
#     :address              => "smtp.gmail.com",
#     :port                 => 587,
#     :domain               => '',
#     :user_name            => '',
#     :password             => '',
#     :authentication       => 'plain',
#     :enable_starttls_auto => true  
#   }
# 
#   ActionMailer::Base.perform_deliveries = true
#   ActionMailer::Base.raise_delivery_errors = true
# 
#   config.action_mailer.default_url_options = { :host => '' }


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  config.assets.enabled = true

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
