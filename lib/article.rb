require_relative 'source.rb'

module SourcePraise
  
  class Article
    
    def initialize(article_data, data_source)
      @article = article_data
      @data_source = data_source
    end
    
    def author(index)
      overflow(index) ? "index overflow" : @article['article'][index]['author']
    end
    
    def title(index)
      overflow(index) ? "index overflow" : @article['article'][index]['title']
    end
    
    def description(index)
      overflow(index) ? "index overflow" : @article['article'][index]['description']
    end
    
    def url(index)
      overflow(index) ? "index overflow" : @article['article'][index]['url']
    end
    
    def source
      @article['source']
    end
    
    private
    def overflow(index)
      index > (@article.length - 1)
    end
    
    def error
      puts 'index overflow'
    end
    
  end
  
end