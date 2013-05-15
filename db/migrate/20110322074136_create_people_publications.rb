class CreatePeoplePublications < ActiveRecord::Migration
  def self.up
    create_table :people_publications, :id=>false do |t|
      t.references :person
      t.references :publication
      
      t.timestamps
    end
  end

  def self.down
    drop_table :people_publications
  end
end
