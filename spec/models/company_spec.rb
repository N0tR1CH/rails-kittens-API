require 'rails_helper'
require 'devise'
require 'faker'

describe Company, type: :model do
  it 'is valid with valid attributes' do
    expect(Company.new).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_many(:users).through(:user_companies) }
    it { is_expected.to have_many(:user_companies) }
  end
end
