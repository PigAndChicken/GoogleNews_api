require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/gnews_api.rb'

describe 'Tests Praise library' do
  SOURCE = 'the-next-web'.freeze
  CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
  GNEWS_TOKEN = CONFIG['gnews_token']
  
  describe 'News information' do
    it 'HAPPY: should provid correct sources attributes' do
      sources = SourcePraise::GnewsAPI.new(GNEWS_TOKEN).sources
      
      _(sources.count).must_equal 70
      _(sources[0]).must_be_kind_of SourcePraise::Source
      _(sources[0].name).must_equal 'ABC News (AU)'
    end
  end
  
  describe 'Articles information' do
    before do
      @sources = SourcePraise::GnewsAPI.new(GNEWS_TOKEN).sources
      @articles = SourcePraise::GnewsAPI.new(GNEWS_TOKEN).articles(@sources[0].id)
    end
    
    it 'HAPPY: should provid correct articles attributes' do
      _(@articles[0]).must_be_kind_of SourcePraise::Article
    end
    
    it 'HAPPY: should identify source' do
      _(@articles[0].source).must_equal @sources[0].id
    end
  end
  
end