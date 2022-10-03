# frozen_string_literal: true

class AddHouseToKittens < ActiveRecord::Migration[7.0]
  def change
    add_reference :kittens, :house, null: true, foreign_key: true
  end
end
