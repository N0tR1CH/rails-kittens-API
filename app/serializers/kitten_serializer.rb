# frozen_string_literal: true

class KittenSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :cuteness, :softness
end
