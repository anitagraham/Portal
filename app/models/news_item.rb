class NewsItem < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 
	strip_attributes

	INDEX_FIELDS = %w(Title Author Published Tagcount)

	default_scope order('pubdate DESC')
	
  has_many :taggings, :as => :taggable, :dependent=>:destroy 
  has_many :tags, :through => :taggings

  attr_accessor :tag_list
  after_save :update_tags
  
  def Published
  	self.pubdate.strftime('%d %b %Y')
  end
  def Name
    self.Title||""
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
