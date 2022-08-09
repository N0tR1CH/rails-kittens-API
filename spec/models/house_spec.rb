require 'rails_helper'
require 'devise'
require 'faker'

describe House, type: :model do
  it 'is valid with valid attributes' do
    expect(House.new(street: 'street', city: 'city')).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:city) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:users).through(:roles)}
  end
end
