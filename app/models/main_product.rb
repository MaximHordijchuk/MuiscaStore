class MainProduct < ActiveRecord::Base
  belongs_to :product

  default_scope -> { order(:position) }

  validates :product, presence: true
  validates :position, presence: true, :numericality => { :greater_than => 0 }
end
