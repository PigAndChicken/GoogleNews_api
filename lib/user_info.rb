require 'yaml'
require 'http'

config = YAML.safe_load(File.read('config/secrets.yml'))

def fb_api_path(path)
  'https://graph.facebook.com/v2.10/' + path
end

def call_fb_url(config, url)
  HTTP.headers(
    'Accept' => 'application/json',
    'Authorization' => "Bearer #{config['fb_token']}"
    ).get(url)
end

fb_response = {}
fb_results = {}

user_url = fb_api_path('me')
fb_response[user_url] = call_fb_url(config, user_url)
user = fb_response[user_url].parse
fb_results['name'] = user['name']
fb_results['id'] = user['id']