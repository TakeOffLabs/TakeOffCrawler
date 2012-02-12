module TakeOffCrawler
  class Link < ActiveRecord::Base
    set_table_name "take_off_crawler_links"
    
    serialize :images
  end
end