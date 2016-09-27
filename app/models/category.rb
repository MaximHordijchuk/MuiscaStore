class Category < ActiveRecord::Base
  has_many :products

  default_scope -> { order(:position) }
end
