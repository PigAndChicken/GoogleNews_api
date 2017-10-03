module SourcePraise
  
  class Source
    
    def initialize(source_data)
      @source = source_data
    end
    
    def all_sources(key)
      source_values = []
      @source.each { |s| source_values << s['#{key}'] }
      source_values
    end
    
    def id(index)
      overflow(index) ? "index overflow" : @source[index]['id']
    end
    
    def name(index)
      overflow(index) ? "index overflow" : @source[index]['name']
    end
    
    def description(index)
      overflow(index) ? "index overflow" : @source[index]['description']
    end
    
    def url(index)
      overflow(index) ? "index overflow" : @source[index]['url']
    end
    
    def category(index)
      overflow(index) ? "index overflow" : @source[index]['category']
    end
    
    def language(index)
      overflow(index) ? "index overflow" : @source[index]['language']
    end
    
    def country(index)
      overflow(index) ? "index overflow" : @source[index]['country']
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