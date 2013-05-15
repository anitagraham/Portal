class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string  :Name
      t.string  :css_class
      t.references :theme
      
      t.timestamps
    end
  end

  def self.down
    drop_table  :tags
  end
end
