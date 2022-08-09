require 'rails_helper'
require 'devise'
require 'faker'

describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(User.new(name: 'some', email: 'example@mail.com', password: 'password')).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:houses) }
    it { is_expected.to have_many(:user_companies) }
    it { is_expected.to have_many(:companies).through(:user_companies) }
  end

  describe '#assign_default_role' do
    let!(:user) { create :user }
    it 'assigns default role newuser for freshly created user' do
      expect(user.roles.any?).to be(true)
    end
  end

  describe '#must_have_a_role' do
    let!(:user) { create :user, roles: [] }
    it 'should check if user have a role and add error if he does not' do
      byebug
      expect(1).to eq(1)
    end
  end
end
