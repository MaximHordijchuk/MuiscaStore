class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :products
  has_many :orders_products, dependent: :destroy

  validates :name, :surname, presence: true, length: { in: 1..50 }
  validates :address, presence: true, length: { in: 1..200 }
  validates :phone, presence: true
end
