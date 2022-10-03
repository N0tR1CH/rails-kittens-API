# frozen_string_literal: true

require 'rails_helper'
require 'devise'
require 'faker'

describe UserSerializer, type: :serializer do
  subject { described_class.new(user).to_h }
  let!(:user) { build :user }
  it 'has a email that matches' do
    is_expected.to include(email: user.email)
  end

  it 'has a id that matches' do
    is_expected.to include(id: user.id)
  end
end
