class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :all_categories, :all_products, :cart_products_count

  def all_categories
    Category.all
  end

  def all_products
    Product.all
  end

  def cart_products_count
    cart = session[:cart]
    amount = 0
    cart.each_value { |val| amount += val } if cart
    amount
  end
end
