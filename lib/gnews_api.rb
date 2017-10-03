require 'http'

module UserPraise
  
  class FbAPI
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
    
    def user
      
    end
  
    private
     
     def gnews_api_path(path)
       'https://newsapi.org/v1/' + path
     end
     
     def call_gnews_url(url)
       result = @cache.fetch(url) do
         HTTP.headers(
           'Accept' => 'application/json',
           'x-api-key' => "#{config['gnews_token']}" ).get(url)
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