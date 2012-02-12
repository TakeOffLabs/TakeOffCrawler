require "take_off_crawler/version"

module TakeOffCrawler
  
  def self.preview content
     require 'open-uri'

     regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\s\%\/_\.\-]*(\?\S+)?)?)?)'
     link = content.match(regex)
     new_link = nil

     if link.present?
       url = link[0]
       url = "http://" + url unless url.match(/^http:/)
       existing_link = Link.find_all_by_link(url).last
       if existing_link.present? && existing_link.updated_at > 2.days.ago
          return existing_link
       else
         new_link = Link.new
         new_link.meta_content = ""
         new_link.link = url

         #check if image link
         regexs = [/.jpeg$/, /.jpg$/, /.png$/, /.gif$/, /.bmp$/]
         regexs.each do |r|
           if r.match(url).present?
             new_link.images = [url]
             new_link.title = "(click to set title and caption)"
             new_link.save
             return new_link
           end
         end

         #check if youtube
         regex = Regexp.new('(https?:\/\/)?(www\.)?youtube.com\/watch\?v=([a-z0-9-]+)\S*', true)
         youtube = content.match(regex)
         if youtube.present? && youtube.length > 3
           new_link.youtube_id = youtube[3]
           url = "http://gdata.youtube.com/feeds/api/videos/" + youtube[3] 
           begin
             new_link = fetch_data_youtube(new_link, url)
           rescue
           end
         else
           begin
             new_link = fetch_data_link(new_link, url)
           rescue
           end
         end
         if new_link.persisted?
           return new_link
         end
       end
     end
     nil
   end


   def self.fetch_data_youtube(new_link, url)    
     images = []
     doc = Nokogiri::HTML(open(url))

     #title
     titles = doc.search('title')
     if !titles.empty?
       new_link.title = titles.first.content
     end

     ## search for meta content
     descriptions = doc.search('description')
     if !descriptions.empty?
       new_link.meta_content = descriptions.first.content
     end

     #search for images
     new_link.images = doc.search('thumbnail').map{|p| p.attribute('url').content}

     if new_link.save
       return new_link
     end
   end

   def self.fetch_data_link(new_link, url)    
     images = []
     doc = Nokogiri::HTML(open(url))

     # title
     titles = doc.search('title')
     if !titles.empty?
       new_link.title = titles.first.content
     end

     # wikipedia
     if url.index("wikipedia").present?
       begin
         new_link.meta_content += doc.search(".mw-content-ltr")[0].search("p").first().content
       rescue
       end
     end

     # search for meta content
     doc.search('meta').each do |m|
       if m.attribute('name').present? && m.attribute('name').value().downcase == 'description'
         new_link.meta_content += m.attribute('content').value()
       end

       if m.attribute('property').present? && m.attribute('property').value().downcase == 'og:description'
         new_link.meta_content += m.attribute('content').value()
       end
     end

     #search for images
     doc.search('img').each do |l|
       url = l.attribute('src').to_s
       url = "http:" + url unless url.match(/^http:/) #hack for wiki
       begin
         img = MiniMagick::Image.open(url)
         width = img[:width]
         height = img[:height]
         images << url if (width > 99 && height > 99) 
         if images.size > 4 
           break
         end
       rescue
       end
     end
     new_link.images = images 

     if new_link.save
      return new_link
     end
   end
end
