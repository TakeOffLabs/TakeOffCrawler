require "take_off_crawler"
require 'rails'

module TakeOffCrawler
  class Engine < Rails::Engine
    config.mount_at = '/'
  end
end