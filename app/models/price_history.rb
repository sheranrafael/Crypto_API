class PriceHistory < ApplicationRecord
  belongs_to :cryptocurrency

  validates :price, numericality: { greater_than: 0 }
  validates :timestamp, presence: true
end