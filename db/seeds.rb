# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating users"
u1 = User.create(email:"juan@test.com", name: "Juan", last_name: "Estebanez", password: "123456", country: "Argentina", city: "La Plata", phone: "5422111233323")
u2 = User.create(email:"carlitos@test.com", name: "Carlos", last_name: "Robert", password: "123456", country: "Argentina", city: "La Plata", phone: "5422188392323")
u3 = User.create(email:"lucho@test.com", name: "Luis", last_name: "Gonzalez", password: "123456", country: "Argentina", city: "La Plata", phone: "542218823740234")
u4 = User.create(email:"happy@test.com", name: "Happy", last_name: "Quinn", password: "123456", country: "Argentina", city: "La Plata", phone: "5422162328373")

puts "Creating tags"
%w[Joven Profesional Arquitecto Música Arte Fiesta Electrónica Comida Repostería Rock Salsa Cumbia Cine Películas Hollywood Fútbol Deportes Libros Lectura Política].map do |tag|
  User.all.each do |user|
    Tag.create(name: tag, user_id: user.id)
  end
end

#  Contacts
puts "Creating contacts"
10.times do
  User.all.each do |user|
    new_contact = Contact.new.tap do |c|
      c.first_name = Faker::Name.first_name
      c.last_name = Faker::Name.last_name
      c.email = Faker::Internet.email(c.first_name)
      c.phone = Faker::PhoneNumber.cell_phone
      c.country = Faker::Address.country
      c.city = Faker::Address.city
      c.user_id = user.id
    end
    new_contact.save
    (rand(5) + 1).times do
      tag_selected = user.tags.sample
      new_contact.tags << tag_selected unless new_contact.tags.include?(tag_selected)
    end
  end
end

# Campaigns
puts "Creating campaign"
new_campaign = Campaign.create(
  title: "El poder de hoy",
  body: "<h1 style='font-variant: small-caps'>Hola</h1>
    <p style='color: gray'>Como estas?</p>
    <p>Te escribimos para ofrecerte <strong>la mejor propuesta de tu vida</strong></p>
    <h3>Saludos</h3>
  ",
  user_id: User.all.first
)

3.times do
  tag_selected = User.first.tags.sample
  new_campaign.tags << tag_selected unless new_campaign.tags.include?(tag_selected)
end

10.times do
  contact_selected = User.first.contacts.sample
  new_campaign.contacts << contact_selected unless new_campaign.contacts.include?(contact_selected)
end

