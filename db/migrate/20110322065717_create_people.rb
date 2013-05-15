class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string  :Firstname
      t.string  :Surname
      t.string  :Position
      t.string  :Role
      t.string  :status
      t.string  :phone
      t.string  :email
      t.string  :mobile
      t.string  :profile
      t.references  :location
      
      t.timestamps  
    end
  end

  def self.down
    drop_table :people
  end
end
