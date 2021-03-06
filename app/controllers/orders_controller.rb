class OrdersController < ApplicationController
  before_filter :ensure_signed_in!
  before_filter :ensure_admin!, except: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.page(params[:page])
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    cart = session[:cart]
    if cart
      cart.each do |id, amount|
        @order.orders_products << OrdersProduct.new(product_id: id, amount: amount)
      end
    else
      redirect_to root_path, notice: 'Your cart is empty. Please, add some staff to your cart before ordering.'
    end

    respond_to do |format|
      if @order.save
        session[:cart] = {}
        format.html { redirect_to thank_path, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :surname, :address, :phone, :card_no, :card_type, :expire_month, :expire_year)
  end

  def ensure_signed_in!
    unless user_signed_in?
      redirect_to new_user_session_path, notice: 'Please, login or register before ordering.'
      false
    end
  end

  def ensure_admin!
    unless current_user.try(:admin?)
      redirect_to root_path, alert: 'Permission denied.'
      false
    end
  end
end
