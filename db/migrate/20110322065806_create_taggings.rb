class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic
      
      t.timestamps
    end
  end

  def self.down
    drop_table :taggings
  end
end
