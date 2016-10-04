class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :products
  has_many :orders_products, dependent: :destroy

  validates :name, :surname, presence: true, length: { in: 1..50 }
  validates :address, presence: true, length: { in: 1..200 }
  validates :phone, presence: true
  validates_format_of :card_no, with: /\A\d{16}|(\d{4}-\d{4}-\d{4}-\d{4})\Z/i, on: :create
  validates :card_type, presence: true, length: { in: 1..30 }
  validates :expire_year, numericality: { greater_than_or_equal_to: 16, less_than_or_equal_to: 99  }
  validates :expire_month, numericality: { greater_than: 1, less_than_or_equal_to: 12 }
end
