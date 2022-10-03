# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe Kitten, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'scope kittens in user house' do
    let!(:auth_headers) { user.create_new_auth_token }
    let!(:user) { create :user, houses: [house] }
    let!(:house) { create :house }
    let!(:kitten) { create :kitten, house_id: house.id }
    let!(:company) { create :company, users: [user] }
    it 'returns kittens in house that belongs to user' do
      expect(Kitten.kittens_in_user_house).to eq([kitten])
    end
  end
end
