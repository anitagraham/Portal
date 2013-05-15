class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.string  :type
      t.string  :Title
      t.string  :Authors
      t.string  :link
      t.string  :with
      t.string  :details
      t.string  :year
      t.string  :status
      t.boolean  :refereed
      
      t.timestamps
    end
  end

  def self.down
    drop_table :publications
  end
end
