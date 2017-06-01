# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find(2)

2.times do 
  user.posts.create({
		name: Faker::Name.name,
		title:Faker::Book.title,
		content:Faker::Lorem.paragraph
		})
end