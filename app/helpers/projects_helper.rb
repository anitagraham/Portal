module ProjectsHelper
	def titleLink
		link_to_unless link.empty?, link, Title
	end
end
