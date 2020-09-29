Koala.configure do |config|
  config.access_token = ENV['FB_ACCESS_TOKEN']
  #config.app_access_token = MY_APP_ACCESS_TOKEN
  #config.app_id = MY_APP_ID
  #config.app_secret = MY_APP_SECRET
  #config.api_version = "v2.0"
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
