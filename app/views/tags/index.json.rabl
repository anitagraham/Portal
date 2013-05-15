collection @tags, object_root: false
attributes  :Title, :name
child :theme_tag => :theme do
	attributes :name
end	