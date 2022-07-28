class Kitten < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { only_integer: true }
end
