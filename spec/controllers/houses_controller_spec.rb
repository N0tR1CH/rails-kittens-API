# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe HousesController do
  let!(:auth_headers) { user.create_new_auth_token }
  let(:user) { create :user }

  before { request.headers.merge! auth_headers }

  describe '[GET] #index' do
    let(:house1)  { create :house }
    let(:house2)  { create :house }
    let(:house3)  { create :house }

    before { get :index }
    context 'normal user' do
      context 'with houses' do
        let(:user) { create :user, houses: [house1, house2, house3] }

        it { expect(JSON.parse(response.body).count).to eq(3) }
      end
      context 'without houses' do
        let!(:houses) { [] }
        it { expect(JSON.parse(response.body).count).to eq(0) }
      end
    end

    context 'admin' do
      let(:user) { create :admin }
      let!(:houses) { create_list :house, 3 }

      before { get :index }
      context 'with houses' do
        it { expect(JSON.parse(response.body).count).to eq(3) }
      end
      context 'without houses' do
        let!(:houses) { [] }
        it { expect(JSON.parse(response.body).count).to eq(0) }
      end
    end
  end

  describe '[GET] #show' do
    context 'normal user' do
      let(:house) { create :house }
      let(:house_id) { house.id }

      context 'normal user can only see his house' do
        let(:user) { create :user, houses: [house] }

        before { get :show, params: { id: house_id } }
        it { expect(JSON.parse(response.body)['id']).to eq(house_id) }
      end

      context 'normal user cannot see houses he has not created' do
        let(:user) { create :user }
        let(:house) { create :house }
        let(:house_id) { house.id }

        before { get :show, params: { id: house_id } }
        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context 'admin user' do
      context 'admin can see everything' do
        let(:user) { create :admin }
        let(:house) { create :house }
        let(:house_id) { house.id }

        before { get :show, params: { id: house_id } }
        it { expect(JSON.parse(response.body)['id']).to eq(house_id) }
      end
    end
  end

  describe '[POST] #create' do
    let(:house_params) { { house: { street: 'street', city: 'city' } } }
    let(:create_request) { post :create, params: house_params }

    it { expect { create_request }.to change { House.count }.from(0).to(1) }
  end

  describe '[PATCH] #update' do
    let(:user) { create :admin }
    let(:house) { create(:house, street: 'street', city: 'city') }
    let(:house_params) { { house: { street: 'new_street', city: 'new_city' }, id: house_id } }
    let(:house_id) { house.id }
    let(:create_request) { patch :update, params: house_params }

    context 'admin can update everything' do
      it { expect { create_request }.to change { house.reload.street }.from('street').to('new_street') }
      it { expect { create_request }.to change { house.reload.city }.from('city').to('new_city') }
    end

    context 'user can update his house' do
      let(:house) { create(:house, street: 'street', city: 'city') }
      let(:user) { create :user, houses: [house] }

      it { expect { create_request }.to change { house.reload.street }.from('street').to('new_street') }
      it { expect { create_request }.to change { house.reload.city }.from('city').to('new_city') }
    end

    context 'user cannot update someone elses houses' do
      let(:house) { create(:house, street: 'street', city: 'city') }
      let(:user) { create :user }
      let(:house_params) { { house: { street: 'new_street', city: 'new_city' }, id: house_id } }
      let(:house_id) { house.id }
      let(:create_request) { patch :update, params: house_params }

      it { expect { create_request }.not_to change { house.reload.street } }
      it { expect { create_request }.not_to change { house.reload.city } }
    end
  end

  describe '[DELETE] #destroy' do
    context 'admin can destroy anything' do
      let!(:house) { create :house }
      let(:user) { create :admin }
      let(:house_id) { house.id }
      let(:create_request) { delete :destroy, params: { id: house_id } }

      it { expect { create_request }.to change { House.count }.from(1).to(0) }
    end

    context 'user can only destroy his houses' do
      let!(:house) { create :house }
      let(:user) { create :user, houses: [house] }
      let(:house_id) { house.id }
      let(:create_request) { delete :destroy, params: { id: house_id } }

      it { expect { create_request }.to change { House.count }.from(1).to(0) }
    end
    let!(:house) { create :house }
    let(:user) { create :user }
    let(:house_id) { house.id }
    let(:create_request) { delete :destroy, params: { id: house_id } }

    it { expect { create_request }.not_to change { House.count } }
    context 'user cannot destroy houses that he does not own' do
    end
  end
end
