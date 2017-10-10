require_relative 'source.rb'

module SourcePraise
  
  class Article
    
    def initialize(article_data)
      @article = article_data
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
      @article['source']
    end
    
  end
  
end