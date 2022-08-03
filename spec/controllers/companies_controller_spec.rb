require 'rails_helper'
require 'devise'
require 'faker'

describe CompaniesController do
  let(:user) { create(:user) }
  let!(:auth_headers) { user.create_new_auth_token }

  before { request.headers.merge! auth_headers } 
end