class CreateUserCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_companies do |t|

      t.timestamps
    end
  end
end
