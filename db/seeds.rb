# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email:"juan@test.com", name: "Juan", last_name: "Estebanez", password: "123456", country: "Argentina", city: "La Plata", phone: "5422111233323")
User.create(email:"carlitos@test.com", name: "Carlos", last_name: "Robert", password: "123456", country: "Argentina", city: "La Plata", phone: "5422188392323")
User.create(email:"lucho@test.com", name: "Luis", last_name: "Gonzalez", password: "123456", country: "Argentina", city: "La Plata", phone: "542218823740234")
User.create(email:"happy@test.com", name: "Happy", last_name: "Quinn", password: "123456", country: "Argentina", city: "La Plata", phone: "5422162328373")

user_ids = User.all.map(&:id)

#  Contacts
puts "Creating contacts"
10.times do
  Contact.new.tap do |c|
    c.first_name = Faker::Name.first_name
    c.last_name = Faker::Name.last_name
    c.email = Faker::Internet.email(c.first_name)
    c.phone = Faker::PhoneNumber.cell_phone
    c.country = Faker::Address.country
    c.city = Faker::Address.city
    c.user_id = user_ids.sample
  end.save
end

# Tags
puts "Creating tags"
50.times do
  t = Tag.new(name: Faker::Lorem.word, user_id: user_ids.sample)
  while t.save == false do
    t.name = Faker::Lorem.word
  end
  rand(20).times do
    rand_number = rand(Contact.all.count)
    contact = Contact.all[rand_number]
    contact.tags << t unless contact.tags.include?(t)
  end
end

# Campaigns
puts "Creating campaign"
c = Campaign.create(
  title: "El poder de hoy",
  body: "<h1 style='font-variant: small-caps'>Hola</h1>
    <p style='color: gray'>Como estas?</p>
    <p>Te escribimos para ofrecerte <strong>la mejor propuesta de tu vida</strong></p>
    <h3>Saludos</h3>
  ",
  user_id: user_ids.first
)

Tag.first(3).each do |tag|
  c.tags << tag
end

Contact.first(5).each do |contact|
  c.contacts << contact
end

