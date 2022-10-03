# frozen_string_literal: true

class HouseSerializer < ActiveModel::Serializer
  attributes :id, :street, :city
  belongs_to :user
end
