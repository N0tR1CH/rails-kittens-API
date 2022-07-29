require 'rails_helper'
require 'devise'
require 'faker'

describe HouseSerializer, type: :serializer do
  let(:user) { create :user }
  let!(:auth_headers) { user.create_new_auth_token }

  let(:house) { FactoryBot.build(:house) }
  let(:serializer) { described_class.new(house, scope: user, scope_name: :current_user) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  it 'has a street that matches' do
    expect(subject['street']).to eql(house.street)
  end

  it 'has a city that matches' do
    expect(subject['city']).to eql(house.city)
  end  
end