require_relative 'source.rb'

module SourcePraise
  
  class Article
    
    def initialize(article_data, source)
      @article = article_data
      @source = source
    end
    
    def author
      @article['article']['author']
    end
    
    def title
      @article['article']['title']
    end
    
    def description
      @article['article']['description']
    end
    
    def url
      @article['article']['url']
    end
    
    def source
      @source
    end
    
  end
  
end