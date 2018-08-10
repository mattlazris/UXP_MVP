# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Cleaning database'
Booking.destroy_all
Experience.destroy_all
User.destroy_all

puts 'Done'

9.times do
  user = User.new(
    first_name: Faker::FunnyName.two_word_name.scan(/\S+/)[0],
    last_name: Faker::FunnyName.two_word_name.scan(/\S+/)[1],
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    description: Faker::StarWars.quote,
    nationality: ['Chinese', 'American', 'German', 'Swedish', 'British', 'Russian', 'Korean', 'French', 'Japanese'].sample,
    occupation: Faker::Job.field,
    hometown: Faker::Address.city,
    interesting_fact: Faker::MostInterestingManInTheWorld.quote,
    gender:['Male', 'Female'].sample,
    password: "123456",
    host: true
  )
  user.save
  rand(0..5).times do
    experience =  Experience.new(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      location: Faker::Address.street_address,
      language: ['English', 'Mandarin', 'Cantonese'].sample,
      category: ['Food & Drink', 'Classes & Workshops', 'Unique tours', 'Sports & Outdoors'].sample,
      price: rand(50..300),
      duration: (1..5).to_a.sample,
      capacity: rand(1..10)，
      # remote_photo_url: [""].sample
    )
    experience.user = user
    experience.save
  end
  user.save
end
