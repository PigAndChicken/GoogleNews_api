module SourcePraise
  
  class Source
    
    def initialize(source_data)
      @source = source_data
    end
    
    def id
      @source['id']
    end
    
    def name
      @source['name']
    end
    
    def description
      @source['description']
    end
    
    def url
      @source['url']
    end
    
    def category
      @source['category']
    end
    
    def language
      @source['language']
    end
    
    def country
      @source['country']
    end
    
  end

end