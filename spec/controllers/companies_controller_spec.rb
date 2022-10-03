# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe CompaniesController do
  let(:user) { create(:admin) }
  let!(:auth_headers) { user.create_new_auth_token }

  before { request.headers.merge! auth_headers }

  describe '[GET] #index' do
    let!(:companies) { create_list :company, 3 }

    before { get :index }
    context 'admin' do
      context 'with companies' do
        it { expect(JSON.parse(response.body).count).to eq(3) }
      end
      context 'without companies' do
        let(:companies) { [] }
        it { expect(JSON.parse(response.body).count).to eq(0) }
      end
    end

    context 'user' do
      context 'cant see companies that he is not a part of' do
        let!(:company1) { create :company }
        let!(:company2) { create :company }
        let!(:company3) { create :company }
        let(:user) { create :user }
        it { expect(JSON.parse(response.body).count).to eq(0) }
      end
      context 'can see companies that he is a part of' do
        let!(:company1) { create :company }
        let!(:company2) { create :company }
        let!(:company3) { create :company }
        let(:user) { create :user, companies: [company1, company2, company3] }
        it { expect(JSON.parse(response.body).count).to eq(3) }
      end
    end
  end

  describe '[GET] #show' do
    let(:user) { create :admin }
    let(:company) { create :company }
    let(:company_id) { company.id }
    context 'admin' do
      context 'can see whatever company he wantsrto' do
        let(:create_request) { get :show, params: { id: company_id } }
        before { create_request }
        it { expect(JSON.parse(response.body)['id']).to eq(company_id) }
      end
    end
    # context 'user' do
    #   context 'user cannot see whatever company he wants to' do
    #     let!(:user) { create :user }
    #     let(:create_request) { get :show, params: { id: company_id } }
    #     let(:company) { create :company }
    #     let(:company_id) { company.id }
    #     before { create_request }
    #     it { expect(response).to have_http_status(:not_found) }
    #   end
    # end
  end

  describe '[POST] #create' do
    let(:user) { create :user }
    let(:company_params) { { company: { name: 'company_name' } } }
    let(:create_request) { post :create, params: company_params }
    it { expect { create_request }.to change { Company.count }.from(0).to(1) }
  end

  describe '[PATCH] #update' do
    let(:user) { create :admin }
    let(:company) { create(:company, name: 'some_company') }
    let(:company_params) { { company: { name: 'other_company' }, id: company_id } }
    let(:company_id) { company.id }
    let(:create_request) { patch :update, params: company_params }

    context 'admin can update everything' do
      it { expect { create_request }.to change { company.reload.name }.from('some_company').to('other_company') }
    end

    context 'user can update his company' do
      let(:company) { create(:company, name: 'user_company') }
      let(:user) { create :user, companies: [company] }
      it { expect { create_request }.to change { company.reload.name }.from('user_company').to('other_company') }
    end

    # context 'user cannot update company hes not a part of' do
    #   let(:user) { create :user }
    #   let(:create_request) { patch :update, params: company_params }
    #   it { expect { create_request }.not_to change { company.reload.name } }
    # end
  end

  describe '[DELETE] #destroy' do
    let(:user) { create :admin }
    let!(:company) { create :company }
    let(:company_id) { company.id }
    let(:create_request) { delete :destroy, params: { id: company_id } }

    context 'admin can destroy anything' do
      it { expect { create_request }.to change { Company.count }.from(1).to(0) }
    end

    # context 'user' do
    #   context 'user can destroy his own company' do
    #     let(:user) { create :user, companies: [company] }
    #     let!(:company) { create :company }
    #     let(:company_id) { company.id }
    #     let(:create_request) { delete :destroy, params: { id: company_id } }
    #     it { expect { create_request }.to change { Company.count }.from(1).to(0) }
    #   end

    #   context 'user cannot destroy company he does not belong to' do
    #     let(:user) { create :user }
    #     let!(:company) { create :company }
    #     let(:company_id) { company.id }
    #     let(:create_request) { delete :destroy, params: { id: company_id } }
    #     it { expect { create_request }.not_to change { Company.count } }
    #   end
    # end
  end

  describe '[POST] #add_user' do
    let(:company) { create :company }
    let(:user) { create :admin }
    let(:user_id) { user.id }
    let(:create_request) { post :add_user, params: user_params }
    let(:user_params) {  { user_ids: [user_id], id: company.id } }

    # it { expect { create_request }.to change(UserCompany, :count).by(1) }
    before { create_request }

    it { expect(company.users).to eq([user]) }
  end
end
