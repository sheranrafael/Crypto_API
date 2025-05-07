class Cryptocurrency < ApplicationRecord
  has_many :price_histories, dependent: :destroy

  validates :symbol, presence: true, uniqueness: true
  validates :name, presence: true
end