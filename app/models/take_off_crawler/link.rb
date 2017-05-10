module TakeOffCrawler
  class Link < CustomConnection
    self.table_name = "take_off_crawler_links"
    
    serialize :images
  end
end
