object @theme
attributes :Title, :name

child :people do
	attributes :Firstname, :Surname, :Position, :Mobile, :Phone, :Profile, :Email, :Taglist, :photo_link
  child :location do
  	attributes :Title
  end
end

child :recent_publications do
	attributes :type, :Title, :Authors, :With, :Details, :Year
end     

child :projects do
	attributes :Title, :Description, :link, :Status
end
	