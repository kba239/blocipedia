require 'random_data'

# Create Users
50.times do
  User.create!(
    email:  RandomData.random_email,
    password:   RandomData.random_sentence
  )
end
users = User.all
