object @tag
attributes :Title, :name

child :people do
	attributes :Firstname, :Surname, :Mobile, :Phone, :Profile, :Email, :Taglist, :Position
	# can't have aliased attributes on the same line as non-aliased attributes
	attributes :thumbnail => :photo
	child :location do
  	attributes :Name
  end
end

child :recent_publications do
	attributes :type, :Title, :Authors, :With, :Details, :Year, :link
end     

child :projects do
	attributes :Title, :Description, :link, :Status
end
	