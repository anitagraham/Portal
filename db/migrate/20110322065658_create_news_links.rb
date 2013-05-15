class CreateNewsLinks < ActiveRecord::Migration
  def self.up
    create_table :news_links do |t|
      t.string :Title
      t.string :link
      t.date :pubdate
      t.references :news_source
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :news_links
  end
end
