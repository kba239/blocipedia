FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
#    confirmed_at Time.now
#    password_confirmation "password"
  end
end
