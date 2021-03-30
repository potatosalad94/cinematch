# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Creating 100 users...'
User.create!(first_name: 'Remi', last_name: 'Achji', email: 'rem@gmail.com', password: '123456')
User.create!(first_name: 'Ben', last_name: 'Merigot', email: 'ben@gmail.com', password: '123456')
100.times do |i|
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.unique.email, password: '123456')
end
puts 'Finished!'
