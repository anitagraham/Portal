class Publication < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 
	
	# remove leading and trailing whitespace from input	strip_attributes
	
  has_many :taggings, :as => :taggable, :dependent=>:destroy
  has_many :tags, :through => :taggings
  has_and_belongs_to_many :people
  belongs_to :project
   
  attr_accessor :tag_list
  before_save :update_tagcount
  after_save :update_tags
  
  default_scope  :order => 'Year DESC'
  scope :since , lambda { |year| where('Year >= ?', year)}
  scope :recent, lambda  { where('Year >=?', Time.now.year-5)}

  scope :with_tag, lambda {|tag| joins(:tags).where('tags.name = ?', tag) }
  
  INDEX_FIELDS = %w(Title Authors Publisher Year tag_count)
  
  def self.subclasses
    %w(Book Chapter Journal Keynote Conference Report Technical)
  end
  
	subclasses.each do |r| 
  	require_dependency r
	end if Rails.env.development?

# Include the type as part of the json serialization
	def as_json(options = {})
		super
		  {type: type,
		 	 Title: Title,
		 	 Authors: authors,
		 	 With: with,
		 	 Details: details,
		 	 Year: year
		 	 }
	end 
	
	def Name
		self.Title.truncate(30) 
	end
	
  def href
    link_to_unless self.link.empty?, self.Title , self.link
  end
  
  def Publisher
  	self.With
  end 
  
  def untagged
  	self.tag_count==0
  end
  
  def self.select_options
    self.subclasses.map{ |c| c.to_s }.sort
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Publication.model_name
      end
    end
    super
  end

  private
	
	def update_tagcount
		self.tag_count = tag_list.nil? ? 0 : tag_list.size
	end
	
  def update_tags
    tags.delete_all
    selected_tags = tag_list.nil? ? [] : tag_list.keys.collect{|id| Tag.find_by_id(id)}
    selected_tags.each {|tag| self.tags << tag}  end

end
