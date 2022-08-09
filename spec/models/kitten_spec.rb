require 'rails_helper'

describe Kitten, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  # describe 'scope kittens in user house' do
  #   let!(:auth_headers) { user.create_new_auth_token }
  #   let!(:user) { create :user }
  #   let!(:user1) { create :user }
  #   let!(:kitten) { create :kitten }
  #   let!(:kitten1) { create :kitten }
  #   context 'returns kittens in house that belongs to user' do
  #     expect(Kitten.kittens_in_user_house).to include(kitten)
  #   end
  #   context 'do not return kittens in house that does not belong to user' do
  #     expect(Kitten.kittens_in_user_house).not_to include(kitten1)
  #   end
  # end
end