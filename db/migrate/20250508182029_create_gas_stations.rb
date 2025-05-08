class CreateGasStations < ActiveRecord::Migration[8.0]
  def change
    create_table :gas_stations do |t|
      t.string     :name, null: false
      t.string     :address, null: false
      t.decimal    :price_per_liter, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
