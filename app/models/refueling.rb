class Refueling < ApplicationRecord
  DEFAULT_DISCOUNT = 0.05

  belongs_to :user
  belongs_to :gas_station

  validates :liters, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
