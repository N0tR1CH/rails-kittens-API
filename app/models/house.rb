class House < ApplicationRecord
  belongs_to :user, optional: true

  validates :street, presence: true
  validates :city, presence: true
end
