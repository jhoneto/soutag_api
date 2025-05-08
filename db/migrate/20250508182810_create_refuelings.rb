class CreateRefuelings < ActiveRecord::Migration[8.0]
  def change
    create_table :refuelings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gas_station, null: false, foreign_key: true
      t.decimal    :liters, precision: 10, scale: 2, null: false
      t.decimal    :total_cost, precision: 10, scale: 2, null: false
      t.decimal    :discount, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
