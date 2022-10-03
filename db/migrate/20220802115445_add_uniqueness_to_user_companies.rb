# frozen_string_literal: true

class AddUniquenessToUserCompanies < ActiveRecord::Migration[7.0]
  def change
    add_index :user_companies, %i[user_id company_id], unique: true
  end
end
