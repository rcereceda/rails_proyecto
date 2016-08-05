# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UserService.destroy_all
User.destroy_all
Service.destroy_all

services = Service.create([{ name: 'Gasfiter (agua)' }, { name: 'Gasfiter (gas)' }, { name: 'Electricista' }])

users = []
10.times do
	users << User.create(email: "#{Faker::Name.first_name.downcase}@gmail.com", password: '123456', name: Faker::Name.name, address: Faker::Address.street_address, phone: Faker::PhoneNumber.cell_phone, is_provider: true)
end

10.times do |i|
	UserService.create(user: users[i], service: services.sample)
end