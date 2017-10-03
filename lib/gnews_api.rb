require 'http'

module UserPraise
  
  class GnewsAPI
    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
    end
    
    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }
    
    def initialize(token, cache = {})
      @gnews_token =token
      @cache = cache
    end
    
    def sources
      sources_req_url = gnews_api_path('sources')
      sources_data = call_gnews_url(sources_req_url).parse
      Source.new(sources_data)
    end
    
    def article(source)
      article_req_url = gnews_api_path('article?source=' + source)
      article_data = call_gnews_url(article_req_url).parse
      Article.new(article_data, self)
    end
  
    private
     
     def gnews_api_path(path)
       'https://newsapi.org/v1/' + path
     end
     
     def call_gnews_url(url)
       result = @cache.fetch(url) do
         HTTP.headers(
           'Accept' => 'application/json',
           'x-api-key' => "#{@gnews_token}" ).get(url)
       end
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