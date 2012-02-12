class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :images
      t.string :link

      t.timestamps
    end
  end
end
