# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe KittenSerializer, type: :serializer do
  subject { described_class.new(kitten).to_h }
  let(:kitten) { build :kitten }

  it 'has a name that matches' do
    is_expected.to include(name: kitten.name)
  end

  it 'has a age that matches' do
    is_expected.to include(age: kitten.age)
  end
end
