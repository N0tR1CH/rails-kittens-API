class Kitten < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { only_integer: true }

  belongs_to :house, optional: true

  resourcify

  scope :kittens_in_user_house, -> { Kitten.joins(house: [user: :companies]) }
end
