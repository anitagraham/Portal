class CreateLocationsProjects < ActiveRecord::Migration
  def self.up
    create_table :locations_projects, :id=>false do |t|
      t.references :location
      t.references :project
      
      t.timestamps
    end
  end

  def self.down
    drop_table :locations_projects
  end
end
