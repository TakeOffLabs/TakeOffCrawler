module TakeOffCrawler
  class Link < DynamicConnection::Base
    self.table_name = "take_off_crawler_links"
    
    serialize :images
  end
end
