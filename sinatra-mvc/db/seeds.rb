require 'faker'

i = 0
while i < 40
	Person.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, birthdate: Faker::Date.between(80.years.ago, 18.years.ago))
	
	i += 1
end