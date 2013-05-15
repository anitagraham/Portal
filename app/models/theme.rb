class Theme < ActiveRecord::Base
  default_scope order('name ASC')
  has_many :tags
	INDEX_FIELDS = %w(Title name Tagcount)
	
	strip_attributes
  
  def Taglist 
  	self.tags.map(&:name).unshift(self.name)
  end
     
  def to_s
    self.Title
  end
  
	def Tagcount
		self.tags.count
	end

end
