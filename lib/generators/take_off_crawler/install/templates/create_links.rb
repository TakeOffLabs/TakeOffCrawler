class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :images
      t.string :link
      t.text :meta_content
      t.text :title
      t.string :youtube_id
      t.timestamps
    end
  end
end
