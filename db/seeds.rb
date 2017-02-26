# Create Users
2.times do
  User.create!(
    user_name: Faker::Internet.user_name,
    email:  Faker::Internet.unique.email,
    password:   Faker::Internet.password
  )
end

dev = User.create!(
  email:  "kate@example.com",
  password:   "password"
)
users = User.all

50.times do
  Wiki.create!(
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph,
    user_name: Faker::Internet.user_name
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
