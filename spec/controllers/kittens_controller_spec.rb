require 'rails_helper'
require 'devise'
require 'faker'

describe KittensController do
    let(:user) { create :user }
    let!(:auth_headers) { user.create_new_auth_token }
    before do
        request.headers.merge! auth_headers
    end

    describe "[GET] index" do
        let!(:kittens) { create_list :kitten, 3 }
        before do
            get :index
        end
        context 'with kittens' do
            it { expect(JSON.parse(response.body).count).to eq(3) }
        end

        context 'without kittens' do
            let!(:kittens) {[]}
            it { expect(JSON.parse(response.body).count).to eq(0) }
        end
    end

    describe "[GET] show" do
        let(:kitten) { create :kitten}
        let!(:kitten_id) { kitten.id }
        before do
            get :show, params: {id: kitten_id}
        end

        context 'with id' do
            it { 
                expect(JSON.parse(response.body)["id"]).to eq(kitten_id) }
        end
        
        context 'without id' do
            let!(:kitten_id) { 'invalidId' }
            
            it { expect(response).to have_http_status(:not_found) }
        end
    end

    describe "[POST] #create" do
        let(:kitten_params) { { kitten: { name: "name" , age: 1 } } }
        let(:create_request) { post :create, params: kitten_params }

        context "correct params" do
            it { expect { create_request }.to change { Kitten.count }.from(0).to(1) }
            it do
                create_request
                expect(response).to have_http_status(201)
            end
        end

        context "uncorrect params" do
            let(:kitten_params) { { kitten: { name: "name" , age: "age" } } }
            let(:create_request) { post :create, params: kitten_params }
            it { expect { create_request }.not_to change { Kitten.count } }
            it do
                create_request
                expect(response).to have_http_status(422)
            end
        end
    end
 
    describe "[PATCH] #update" do
        let(:kitten) { create(:kitten, name: "other", age: 1) }
        let(:kitten_params) { { kitten: { name: "name" , age: 7 }, id: kitten_id } }
        let(:kitten_id) { kitten.id }
        let(:create_request) { patch :update, params: kitten_params }
        context 'with proper data' do
            it { expect { create_request }.to change { kitten.reload.name }.from("other").to("name") }
            it { expect { create_request }.to change { kitten.reload.age }.from(1).to(7) }
            it do
                create_request
                expect(response).to have_http_status(204)
            end
        end
        context 'with unproper data' do
            let(:kitten_params) { { kitten: { name: 7 , age: "age" }, id: kitten_id } }
            it { expect { create_request }.not_to change { kitten.reload.name } }
            it { expect { create_request }.not_to change { kitten.reload.age } }
            it do
                create_request
                expect(response).to have_http_status(304)
            end
        end
    end 

    describe "[DELETE] #destroy" do
        let(:kitten) { create :kitten}
        let!(:kitten_id) { kitten.id }
        let(:create_request) { delete :destroy, params: {id: kitten_id} }
        context 'kitten deleted successfully' do
            it { expect { create_request }.to change { Kitten.count }.from(1).to(0) }
            it do
                create_request
                expect(response).to have_http_status(200)
            end
        end
    end
end