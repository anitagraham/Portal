class CreateProjectsPublications < ActiveRecord::Migration
  def self.up
    create_table :projects_publications, :id=>false do |t|
      t.references :project
      t.references :publication
      
      t.timestamps
    end
  end

  def self.down
    drop_table :projects_publications
  end
end
