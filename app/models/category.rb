class Category < ActiveRecord::Base
  has_many :products

  default_scope -> { order(:position) }

  validates :name, presence: true, uniqueness: true, length: { in: 1..30 }
  validates :position, presence: true, :numericality => { :greater_than => 0 }
end
