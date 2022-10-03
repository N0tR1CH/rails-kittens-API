# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe HouseSerializer, type: :serializer do
  subject { described_class.new(house).to_h }
  let(:house) { build :house }
  # let(:serializer) { described_class.new(house).to_h }

  it 'has a street that matches' do
    is_expected.to include(street: house.street)
    # expect(serializer[:street]).to eq(house.street)
  end

  it 'has a city that matches' do
    is_expected.to include(city: house.city)
  end
end
