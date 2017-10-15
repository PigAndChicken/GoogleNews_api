require 'http'
require_relative 'source.rb'
require_relative 'article.rb'

module SourcePraise
  
  class GnewsAPI
    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
    end
    
    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }
    
    def initialize(token)
      @gnews_token =token
    end
    
    def sources
      sources_req_url = gnews_api_path('sources')
      sources_data = call_gnews_url(sources_req_url).parse
      sources_data = sources_data['sources']
      sources_data.map { |source_data| Source.new(source_data) }
    end
    
    def articles(source)
      article_req_url = gnews_api_path('articles?source=' + source)
      articles_data = call_gnews_url(article_req_url).parse
      articles = articles_data['articles']
      articles.map { |article_data| Article.new(article_data,articles_data['source']) }
    end
  
    private
     
     def gnews_api_path(path)
       'https://newsapi.org/v1/' + path
     end
     
     def call_gnews_url(url)
       result = 
         HTTP.headers(
           'Accept' => 'application/json',
           'x-api-key' => "#{@gnews_token}" ).get(url)
       successful?(result) ? result : raise_error(result)
     end
     
     def successful?(result)
       HTTP_ERROR.keys.include?(result.code) ? false : true
     end
     
     def raise_error(result)
       raise(HTTP_ERROR[result.code])
     end
     
  end
  
end