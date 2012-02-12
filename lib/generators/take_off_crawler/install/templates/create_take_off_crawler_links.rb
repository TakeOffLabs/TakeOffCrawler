class CreateTakeOffCrawlerLinks < ActiveRecord::Migration
  def change
    create_table :take_off_crawler_links do |t|
      t.text :images
      t.string :link
      t.text :meta_content
      t.text :title
      t.string :youtube_id
      t.timestamps
    end
  end
end
