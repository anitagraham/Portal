class User < ActiveRecord::Base
  default_scope order('Name ASC')
	INDEX_FIELDS = %w(status Name email)
	
	has_secure_password
  validates_presence_of :password, presence: {on: create}, length: { minimum: 8, allow_blank: true }, :if => :password_digest_changed?
  
  attr_accessible :Name, :email, :password, :password_confirmation, :disabled
  validates_presence_of :email
  validates_uniqueness_of :email  
  
  before_create :downcase_email
  
  def status
  	self.disabled ? "Disabled" : "Enabled"
  end

  def disable
    update_attribute(:disabled, true)
  end
  
  def enable
  	update_attribute(:disabled, false)
  end
  
  private
  def downcase_email
    self.email.downcase!
  end

end
