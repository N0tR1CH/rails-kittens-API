FactoryBot.define do
  factory :user do
      email { Faker::Internet.email }
      password { "password" }
      password_confirmation { "password" }
  end
end


# {
#   "email": "test@email.com",
#   "password": "password",
#   "password_confirmation": "password"
# }