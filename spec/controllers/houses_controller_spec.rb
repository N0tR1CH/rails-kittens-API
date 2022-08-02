require 'rails_helper'
require 'devise'
require 'faker'

describe HousesController do
  let(:user) { create(:user) }
  let!(:auth_headers) { user.create_new_auth_token }

  before do 
    request.headers.merge! auth_headers
  end
  describe "[POST] #create" do
    let(:house_params) { { house: { street: "street", city: "city" } } }    
    let(:create_request) { post :create, params: house_params }
    it { expect { create_request }.to change { House.count }.from(0).to(1) }
  end
end

# User
# has_many :user_companies
# has_many :companies, through: user_company

# UserCompany
# belongs_to :user
# belongs_to :company

# Company
# has_many :user_companies
# has_many :users, through: user_comapny
