class Product < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :category
  has_many :product_attachments
  accepts_nested_attributes_for :product_attachments
end
