class NewsSource < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 
	URL_PREFIX = "http://"	
  default_scope order('Name ASC')
  has_many :NewsItems

	INDEX_FIELDS = %w(Name Link)
	
	def url=(_url)
		u = URI.parse(_url)
		if(!u.scheme)
			url = _url.prepend(URL_PREFIX)
		else
			url = _url
		end
		super(url)
	end
	
	def Link	
    link_to_unless self.url.blank?, self.abbreviation , self.url
	end
	
	# def itemCount
		# self.NewsItems.count
	# end
	
	def to_s
    self.Name
  end
end
