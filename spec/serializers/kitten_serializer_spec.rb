require 'rails_helper'
require 'devise'
require 'faker'

describe KittenSerializer do
  let(:user) { create :user }
  let!(:auth_headers) { user.create_new_auth_token }

  let(:kitten) { FactoryBot.build(:kitten) }
  let(:serializer) { described_class.new(kitten, scope: user, scope_name: :current_user) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  it 'has a name that matches' do
    expect(subject['name']).to eql(kitten.name)
  end

  it 'has a age that matches' do
    expect(subject['age']).to eql(kitten.age)
  end  
end