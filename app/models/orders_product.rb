class OrdersProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
