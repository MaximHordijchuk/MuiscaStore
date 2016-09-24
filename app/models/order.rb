class Order < ActiveRecord::Base
  belongs_to :buyer
  has_and_belongs_to_many :products
  has_many :orders_products
end