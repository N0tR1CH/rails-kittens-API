require 'rails_helper'

describe HousePolicy, type: :policy do
  subject { described_class.new(user, house) }

  let(:house) { House.create }

  context 'being a new user' do
    let(:user) {  }
    
  end

  context 'being an administrator' do

  end
end
