namespace :publications do

	desc "Add the tag 'salinity' to any publication which has Ed Barrett-Lennard as an Author"
	task :updateSalinity => :environment do
		salinity = Tag.where("name=?","salinity")
		ed = Person.where("Surname=?","Barrett-Lennard")
		pubs = Publication.joins(:people).merge(ed).readonly(false)
		pubs.each do |p|
			p.tags<<salinity
			p.save
			puts "Updated #{p.Name}"
		end
	end
	
	desc "Crosscheck tags on Publications and fix missing tags"
	task :crosscheckTags1 => :environment do
		tags = Tag.all
		tags.each do |t|
			print "Updating publications for #{t.name}..."
			pubs = t.publications
			print "Looking at #{pubs.count} Publications"
			pubs.each do |p|
				p.tags << t
				p.save!
			end
			print "Done. \n"
		end
	end
	
	desc "Crosscheck tags on Publications and fix missing tags"
	task :crosscheckTags2 => :environment do
		pubs = Publication.all
		pubs.each do |p|
			tags = p.tags
			print "Looking at #{p.Title} tags (#{tags.count})..." if tags.count>0
			tags.each do |t|
				t.publications << p
				t.save!
			end
		end
		print "Done. \n"
	end	
	desc "Update the tag counter"
	task :updateTagCounter => :environment do
		puts "Beginning tag counter update"
		pubs = Publication.all
		print "There are #{pubs.count} publications to process\n"
		pubs.each_with_index do |p, i|
			p.tag_count = p.tags.count
			p.save!
			print '.' if (i % 10 == 0)
		end
		print "\n"
	end	
end