class ProductAttachmentsController < ApplicationController
  before_filter :ensure_admin!
  before_action :set_product
  before_action :set_product_attachment, only: [:edit, :update, :destroy]

  # GET /product_attachments/new
  def new
    @product_attachment = @product.product_attachments.new
  end

  # GET /products/1/product_attachments/1/edit
  def edit
  end

  # POST /products/1/product_attachments
  # POST /products/1/product_attachments.json
  def create
    @product_attachment = @product.product_attachments.new(product_attachment_params)

    respond_to do |format|
      if @product_attachment.save
        format.html { redirect_to edit_product_url(@product), notice: 'Image was successfully added.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /products/1/product_attachments/1
  # PATCH/PUT /products/1/product_attachments/1.json
  def update
    respond_to do |format|
      if @product_attachment.update(product_attachment_params)
        format.html { redirect_to edit_product_url(@product), notice: 'Image was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1/product_attachments/1
  # DELETE /products/1/product_attachments/1.json
  def destroy
    @product_attachment.destroy
    respond_to do |format|
      format.html { redirect_to edit_product_url(@product), notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product_attachment
      @product_attachment = @product.product_attachments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_attachment_params
      params.require(:product_attachment).permit(:image, :product_id)
    end

    def ensure_admin!
      unless current_user.try(:admin?)
        redirect_to root_path, alert: 'Permission denied.'
        false
      end
    end
end
