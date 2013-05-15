class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.string :Title
      t.string :Author
      t.string :link
      t.date :pubdate
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :news_items
  end
end
