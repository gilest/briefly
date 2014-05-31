class Tweeter

  def initialize
    credentials = YAML.load_file('config/secrets.yml')['twitter']

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials['consumer_key']
      config.consumer_secret     = credentials['consumer_secret']
      config.access_token        = credentials['access_token']
      config.access_token_secret = credentials['access_token_secret']
    end
  end

  def client
    @client
  end

end