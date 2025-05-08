class GasStation < ApplicationRecord
  has_many :refuelings, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :price_per_liter, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
