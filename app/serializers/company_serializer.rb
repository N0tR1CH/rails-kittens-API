class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :user_companies
  has_many :users, through: :user_companies
end
