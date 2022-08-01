class House < ApplicationRecord
  belongs_to :user, optional: true

  validates :street, presence: true
  validates :city, presence: true

  resourcify

  has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
  has_many :moderators, -> { where(:roles => {name: :moderator}) }, through: :roles, class_name: 'User', source: :users
end
