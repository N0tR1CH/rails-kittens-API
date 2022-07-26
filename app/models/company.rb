# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :user_companies
  has_many :users, through: :user_companies
end
