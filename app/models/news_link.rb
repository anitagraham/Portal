class NewsLink < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 
	
	default_scope order('pubdate DESC')
	INDEX_FIELDS = %w(Title Source Published)

  has_many :taggings, :as => :taggable, :dependent=>:destroy  
  has_many :tags, :through => :taggings
  
  
  belongs_to :news_source

  attr_accessor :tag_list
  after_save :update_tags
  
  def Name
    link_to_unless self.link.blank?, self.Title , self.link
  end
  
  def Source
  	if self.news_source
  		link_to self.news_source.abbreviation, self.news_source.url
  	else
  		""
  	end
  end
  
  def Published
  	pubdate.strftime("%e %b, %Y")
  end
  
 	def Tagcount
		self.tags.count
	end
	 
 
 private
  def update_tags
    tags.delete_all
    selected_tags = tag_list.nil? ? [] : tag_list.keys.collect{|id| Tag.find_by_id(id)}
    selected_tags.each {|tag| self.tags << tag}
  end
end
