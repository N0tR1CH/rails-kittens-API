# frozen_string_literal: true

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  extend Devise::Models

  # associations
  has_many :houses
  has_many :user_companies
  has_many :companies, through: :user_companies

  # after an user is create within the database we are giving him a role newuser
  after_create :assing_default_role

  validate :must_have_a_role, on: :update

  private

  def assing_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least 1 role")
    end
  end
end
