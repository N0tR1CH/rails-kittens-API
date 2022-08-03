require 'rails_helper'
require 'devise'
require 'faker'

describe CompaniesController do
  let(:user) { create(:admin) }
  let!(:auth_headers) { user.create_new_auth_token }

  before { request.headers.merge! auth_headers }

  describe '[POST] #add_user' do
    let(:company) { create :company }
    let(:user) { create :user }
    let(:user_id) { user.id }
    let(:create_request) { post :add_user, params: user_params}
    let(:user_params) {  { user_ids: [user_id], id: company.id } }

    #it { expect { create_request }.to change(UserCompany, :count).by(1) }
    before { create_request }

    it { expect(company.users).to eq([user]) }
  end
end