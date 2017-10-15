require 'yaml'
require 'http'

config = YAML.safe_load(File.read('config/secrets.yml'))

def gnews_api_path(path)
  'https://newsapi.org/v1/' + path
end

def call_gnews_url(config, url)
  HTTP.headers(
    'Accept' => 'application/json',
    'x-api-key' => "#{config['gnews_token']}"
    ).get(url)
end

gnews_response = {}
gnews_results = []

sources_url = gnews_api_path('sources')
gnews_response[sources_url] = call_gnews_url(config, sources_url)
sources = gnews_response[sources_url].parse

sources = sources['sources']
sources.each do |source|
  result = {}
  result['id'] = source['id']
  result['name'] = source['name']
  result['description'] = source['description']
  result['url'] = source['url']
  result['category'] = source['category']
  result['language'] = source['language']
  result['country'] = source['country']
  gnews_results.push(result)
end

File.write('spec/fixtures/gnews_response.yml', gnews_response.to_yaml)
File.write('spec/fixtures/gnews_results.yml', gnews_results.to_yaml)