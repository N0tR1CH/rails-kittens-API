class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :street
      t.string :city
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
