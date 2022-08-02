require 'rails_helper'
require 'pundit/rspec' 

describe HousePolicy, type: :policy do
  let(:records) { HousePolicy::Scope.new(user, House).resolve }

  describe "Scope" do
    let!(:house) { create :house }
    let!(:admin_house) { create :house }

    context 'new user' do
      let(:user) { create :user, houses: [house] }
      it { expect(records).to include(house) }
      it { expect(records).not_to include(admin_house) }
    end
    
    context 'admin' do
      let(:user) { create :admin, houses: [admin_house] }

      it { expect(records).to include(admin_house) }
      it { expect(records).to include(house) }
    end
  end 
end
