# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    user
    street { 'MyString' }
    city { 'MyString' }
  end
end
