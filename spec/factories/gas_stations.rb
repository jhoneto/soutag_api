# filepath: /home/hamilton/Documents/projects/outlabs/soutag_api/spec/factories/gas_stations.rb
FactoryBot.define do
  factory :gas_station do
    name { Faker }
    address { Faker::Address.full_address }
    price_per_liter { 5.99 }
  end
end
