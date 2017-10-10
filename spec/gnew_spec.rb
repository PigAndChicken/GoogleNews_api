require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/gnews_api.rb'

describe 'Tests Praise library' do
  SOURCE = 'the-next-web'.freeze
  CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
  GNEWS_TOKEN = CONFIG['gnews_token']
  CORRECT = YAML.safe_load(File.read('fixtures/gnews_results.yml'))
  RESPONSE = YAML.safe_load(File.read('fixtures/gnews_response.yml'))
  
  describe 'Source information' do
    it 'HAPPY: should provide correct source attributes' do
      sources = SourcePraise::GnewsAPI.new(GNEWS_TOKEN, cache=RESPONSE).sources
      _(sources.count).must_equal CORRECT.count
    end
  end
  
end