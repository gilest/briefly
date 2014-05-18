class Tweeter

  def initialize
    keys = YAML.load_file 'config/keys.yml'

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['twitter']['consumer_key']
      config.consumer_secret     = keys['twitter']['consumer_secret']
      config.access_token        = keys['twitter']['access_token']
      config.access_token_secret = keys['twitter']['access_token_secret']
    end
  end

  def client
    @client
  end

end