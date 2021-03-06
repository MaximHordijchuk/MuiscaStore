class CartController < ApplicationController
  before_action :set_cart

  # get /cart
  def index
    cart = session[:cart]
    if cart
      cart = cart.select { |id, _| Product.find_by_id(id) }
      session[:cart] = cart
      @cart = cart.map { |id, amount| { product: Product.find(id), amount: amount } }
      @total = @cart.inject(0) { |sum, hash| sum + hash[:product].price * hash[:amount] }
    else
      redirect_to root_path, notice: 'Your cart is empty. Please, add some staff to your cart before ordering.'
    end
  end

  # post /add_product
  def add
    product_id = params[:product][:id]
    if Product.find(product_id)
      amount = params[:product][:amount].to_i
      if amount < 1
        redirect_to product_path(product_id), alert: 'Amount should be more than 0.'
        return
      end
      if @cart[product_id]
        @cart[product_id] += amount
      else
        @cart[product_id] = amount
      end
      redirect_to product_path(product_id), notice: 'Products have been added to your card.' and return
    end
    redirect_to root_path, alert: 'Couldn\'t add product. Product not found.'
  end

  # patch /update_product
  def update
    product_id = params[:product][:id]
    if @cart[product_id]
      amount = params[:product][:amount].to_i
      if amount < 1
        redirect_to product_path(product_id), alert: 'Amount should be more than 0.'
        return
      end
      @cart[product_id] = amount
      redirect_to product_path(product_id) and return
    end
    redirect_to root_path, alert: 'Couldn\'t update product. Product not found.'
  end

  # delete /remove_product/1
  def remove
    product_id = params[:id]
    if @cart[product_id]
      @cart.delete(product_id)
      redirect_to cart_path and return
    end
    redirect_to root_path, alert: 'Couldn\'t remove product. Product not found.'
  end

  # patch /increase_amount/1
  def increase
    product_id = params[:id]
    @cart[product_id] += 1 if @cart[product_id]
    redirect_to cart_path
  end

  # patch /decrease_amount/1
  def decrease
    product_id = params[:id]
    @cart[product_id] -= 1 if @cart[product_id] && @cart[product_id] > 1
    redirect_to cart_path
  end

  private

  def set_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end