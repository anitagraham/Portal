class CreateTagsThemes < ActiveRecord::Migration
  def self.up
    create_table :tags_themes, :id=>false do |t|
      t.references :tag
      t.references :theme
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tags_themes
  end
end
