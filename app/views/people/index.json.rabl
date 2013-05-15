collection @people => :people
attributes :Firstname, :Surname, :Mobile, :Phone, :Profile, :Status, :Role, :Email, :Position
child :location do
  attributes :Name
end