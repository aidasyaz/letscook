# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# seed users
user = {}
user['password'] = 'asdf'
user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
	20.times do
		user['name'] = Faker::Name.name
		user['email'] = Faker::Internet.email
		User.create!(user)
	end
end

# Seed Listings
recipe = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
	50.times do
		recipe['name'] = Faker::Food.dish
		recipe['description'] = Faker::Food.description
		recipe['ingredients'] = Faker::Food.ingredient
		recipe['instructions'] = Faker::Hipster.sentence
		recipe['posted_at'] = Faker::Time.between(DateTime.now - 1, DateTime.now)
		
		recipe['user_id'] = uids.sample

		Recipe.create(recipe)
	end
end