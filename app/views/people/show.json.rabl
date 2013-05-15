object @person
attributes :Firstname, :Surname, :Mobile, :Phone, :Profile, :Position, :Role, :Email, :blurb, :Taglist
# can't have aliased attributes on the same line as non-aliased attributes
attributes :portrait => :photo
child :location do
  attributes :Name
end

child :recent_publications do
	attributes :type, :Title, :Authors, :With, :Details, :Year
end     
