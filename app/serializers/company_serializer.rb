class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users_companies
  has_many :users, through: :users_companies
end
