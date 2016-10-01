class Product < ActiveRecord::Base
  belongs_to :category
  has_many :product_attachments
  accepts_nested_attributes_for :product_attachments
  has_and_belongs_to_many :orders

  MAX_PRODUCT_ATTACHMENTS = 10

  validate :validate_product_attachments
  validates :article, presence: true, uniqueness: true
  validates :name, presence: true, length: { in: 1..50 }
  validate :validate_price


  def main_image(version = nil)
    if product_attachments.size > 0
      if version
        product_attachments.first.image.url(version)
      else
        product_attachments.first.image
      end
    else
      ActionController::Base.helpers.asset_path('default_product.gif')
    end
  end

  private

  def validate_product_attachments
    if product_attachments.size > MAX_PRODUCT_ATTACHMENTS
      errors.add(:product_attachments, "too many. Maximum: #{MAX_PRODUCT_ATTACHMENTS}")
    end
  end

  def validate_price
    validates_numericality_of :price, :on => :create if price
  end
end
