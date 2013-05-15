class Tagging < ActiveRecord::Base  
  belongs_to :taggable, :polymorphic => true
  belongs_to :publication,  :class_name => "Publication", :foreign_key => "taggable_id"
  belongs_to :person,				:class_name => "Person", 			:foreign_key => "taggable_id"
	belongs_to :project, 			:class_name=> "Project", 			:foreign_key => "taggable_id"     
	belongs_to :location, 		:class_name=> "Location", 		:foreign_key => "taggable_id"                        
                   
  belongs_to :tag
  
  validates_uniqueness_of :tag_id, :scope => [:taggable_id, :taggable_type]
end  