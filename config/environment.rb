if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/briefly2/.gems' #+ ':/usr/lib/ruby/gems/1.8'  # Need this or Passenger fails to start
  require '/home/briefly2/.gems/gems/rack-1.2.1/lib/rack.rb'  # Need this for EACH LOCAL gem you want to use, otherwise it uses the ones in /usr/lib
end


# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Huffpost::Application.initialize!