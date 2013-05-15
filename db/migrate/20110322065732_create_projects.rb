class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string  :Title
      t.string  :description
      t.string  :link
      t.string  :status
      
      t.timestamps
    end
  end

  def self.down
    drop_table  :projects
  end
end
