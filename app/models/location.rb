class Location < ActiveRecord::Base
  default_scope order('Name')
	strip_attributes
  has_many :people, :inverse_of => :location
  has_and_belongs_to_many :projects
	
	INDEX_FIELDS = %w(Name)
  def to_s
    self.Name
  end
  
  def People
  	self.people.count
  end
  
  def Projects
  	self.projects.count
  end
end
