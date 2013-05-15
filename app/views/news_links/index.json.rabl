collection @news_links => :news_links
attributes :Title, :link
child :news_source do
  attributes :abbreviation, :url
end
