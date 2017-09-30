# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Contacts
10.times do
  Contact.new.tap do |c|
    c.first_name = Faker::Name.first_name
    c.last_name = Faker::Name.last_name
    c.email = Faker::Internet.email(c.first_name)
    c.phone = Faker::PhoneNumber.cell_phone
    c.country = Faker::Address.country
    c.city = Faker::Address.city
  end.save
end

# Tags
50.times do
  t = Tag.create(name: Faker::Lorem.word)
  rand(20).times do
    rand_number = rand(Contact.all.count)
    contact = Contact.all[rand_number]
    contact.tags << t unless contact.tags.include?(t)
  end
end