class MainProductsController < ApplicationController
  before_filter :ensure_admin!
  before_action :set_main_product, only: [:edit, :update, :destroy]

  # GET /main_products
  # GET /main_products.json
  def index
    @main_products = MainProduct.all.page(params[:page])
  end

  # GET /main_products/new
  def new
    @main_product = MainProduct.new
  end

  # GET /main_products/1/edit
  def edit
  end

  # POST /main_products
  # POST /main_products.json
  def create
    @main_product = MainProduct.new(main_product_params)
    MainProduct.transaction do
      respond_to do |format|
        if @main_product.save
          update_positions
          format.html { redirect_to main_products_path, notice: 'Product was successfully added to Main page.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /main_products/1
  # PATCH/PUT /main_products/1.json
  def update
    old_position = @main_product.position
    MainProduct.transaction do
      respond_to do |format|
        if @main_product.update(main_product_params)
          update_positions old_position
          format.html { redirect_to main_products_path, notice: 'Product was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /main_products/1
  # DELETE /main_products/1.json
  def destroy
    @main_product.destroy
    respond_to do |format|
      format.html { redirect_to main_products_url, notice: 'Main product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_product
      @main_product = MainProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_product_params
      params.require(:main_product).permit(:product_id, :position)
    end

    def ensure_admin!
      unless current_user.try(:admin?)
        redirect_to root_path, alert: 'Permission denied.'
        false
      end
    end

    def update_positions(old_pos = nil)
      @main_product.position = 1 if @main_product.position < 1
      all_products = MainProduct.where.not(id: @main_product.id)
      max_pos = all_products.maximum(:position)
      new_pos = @main_product.position
      if new_pos > max_pos + 1
        new_pos = max_pos + 1
        @main_product.position = new_pos
      end
      updates = {}
      if old_pos
        if old_pos < new_pos
          products = all_products.where(position: (old_pos + 1)..new_pos)
          products.each { |p| updates[p.id] = { position: p.position - 1 } }
        elsif new_pos < old_pos
          products = all_products.where(position: new_pos...old_pos)
          products.each { |p| updates[p.id] = { position: p.position + 1 } }
        end
      elsif new_pos <= max_pos
        products = all_products.where(position: new_pos..max_pos)
        products.each { |p| updates[p.id] = { position: p.position + 1 } }
      end
      MainProduct.update(updates.keys, updates.values) if updates.any?
      @main_product.save!
    end
end
