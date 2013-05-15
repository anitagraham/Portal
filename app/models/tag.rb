class Tag < ActiveRecord::Base
	INDEX_FIELDS = %w(Title name News Publications Projects People)
	TAGGED_OBJECTS = %w(People Publications Projects locations)
	default_scope order("Title ASC")
	strip_attributes
	
	scope :themes,  lambda {where("theme=?",true)}
	# scope :unaligned, lambda {where("theme=?",false).joins()}
  scope :orphan, lambda {where("theme is NULL AND theme_id is NULL")}
  
	belongs_to :theme_tag, :class_name => "Tag", :foreign_key => "theme_id"
	has_many 	 :subthemes, :class_name => "Tag", :foreign_key => "theme_id"
	
	# 	POLYMORPHIC
  belongs_to :taggable, :polymorphic => true
  has_many :taggings, :dependent => :destroy
  has_many :news_items, 	:through => :taggings, :source => :taggable, :source_type => "NewsItem"
  has_many :news_links, 	:through => :taggings, :source => :taggable, :source_type => "NewsLink"
  has_many :publications, :through => :taggings, :source => :taggable, :source_type => "Publication"
  has_many :projects, 		:through => :taggings, :source => :taggable, :source_type => "Project"
  has_many :locations, 		:through => :taggings, :source => :taggable, :source_type => "Location"
  has_many :people,  			:through => :taggings, :source => :taggable, :source_type => "Person"
  
  attr_accessible :Title, :name, :theme_id, :theme, :publication_ids, :person_ids, :project_ids, :location_ids, :subtheme_ids
  after_save :update_links
  
  validates :name, :uniqueness=>true
    
  def to_s
  	self.Title
  end
  
  def status
  	if self.theme
  		"Theme"
  	elsif self.theme_tag
  		"Subtheme"
  	else
  		"Orphan"
		end
	end
	
  def News
  	self.news_items_count + self.news_links_count
  end
  
  def recent_publications
    self.publications.recent
  end

  def Publications
  	self.publications_count
  end
  
  def Projects
  	self.projects_count
  end
  
  def People
  	self.people_count
  end
  
	private
  def update_links
#  	
    # selected_people = person_ids.nil? ? [] : person_ids.collect {|id| Person.find_by_id(id)}
    # selected_people.each { |p| self.people << p unless self.people.include?(p)}
#     
    # selected_newsitems = newsitem_ids.nil? ? [] : newsitem_ids.collect {|id| Newsitem.find_by_id(id)}
    # selected_newsitems.each {|p| self.newsitems << p unless self.newsitems.include?(p)}
#     
    # selected_projects = project_ids.nil? ? [] : project_ids.collect {|id| Project.find_by_id(id)}
    # selected_projects.each {|p| self.projects << p unless self.projects.include?(p)}
#     
    # selected_publications = publication_ids.nil? ? [] : publication_ids.collect{|id| Publication.find_by_id(id)}
    # selected_publications.each {|p| self.publications << p unless self.publications.include?(p)}
#     
    # selected_locations = location_ids.nil? ? [] : location_ids.collect{|id| Location.find_by_id(id)}
    # selected_locations.each {|p| self.locations << p unless self.locations.include?(p)}
  end
end
