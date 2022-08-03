require 'rails_helper'
require 'pundit/rspec' 

describe CompanyPolicy, type: :policy do
  subject { described_class.new(user, company) }

  describe "Adding users to the company." do
    let!(:company) { create :company }

    context 'admin' do
      let(:user) { create :admin }
      it { is_expected.to permit_action(:add_user)}
    end

    context 'newuser' do
      let(:user) { create :user }
      it { is_expected.to forbid_action(:add_user)}
    end
  end 
end
