require 'rails_helper'
require 'devise'
require 'faker'

describe HousesController do
  let(:user) { create(:user) }
  let!(:auth_headers) { user.create_new_auth_token }

  before { request.headers.merge! auth_headers } 
      
end