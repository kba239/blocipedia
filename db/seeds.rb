require 'random_data'

# Create Users
2.times do
  User.create!(
    email:  RandomData.random_email,
    password:   RandomData.random_sentence
  )
end

dev = User.create!(
  email:  "kate@example.com",
  password:   "password"
)
users = User.all

50.times do
  Wiki.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_sentence,
    user: users.sample
  )
end
