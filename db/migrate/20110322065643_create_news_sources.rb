class CreateNewsSources < ActiveRecord::Migration
  def self.up
    create_table :news_sources do |t|
      t.string :Name
      t.string :abbreviation
      t.string :url
      
      t.timestamps
    end
  end

  def self.down
    drop_table :news_sources
  end
end
