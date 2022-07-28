FactoryBot.define do
  factory :user do
      email { "example@mail.com" }
      password { "password" }
      password_confirmation { "password" }
  end
end


# {
#   "email": "test@email.com",
#   "password": "password",
#   "password_confirmation": "password"
# }