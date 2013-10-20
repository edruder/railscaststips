# for twitter api 1.1

TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]

Twitter.configure do |config|
  config.consumer_key       = TWITTER_CONFIG['consumer_key']
  config.consumer_secret    = TWITTER_CONFIG['consumer_secret']
  config.oauth_token        = TWITTER_CONFIG['oauth_token']
  config.oauth_token_secret = TWITTER_CONFIG['oauth_token_secret']
end
