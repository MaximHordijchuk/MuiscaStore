class CategoriesController < ApplicationController
  before_filter :ensure_admin!, except: [:show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.page(params[:page])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @products = @category.products.page(params[:page])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    Category.transaction do
      respond_to do |format|
        if @category.save
          update_positions
          format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    old_position = @category.position
    Category.transaction do
      respond_to do |format|
        if @category.update(category_params)
          update_positions old_position
          format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :position)
    end

    def ensure_admin!
      unless current_user.try(:admin?)
        redirect_to root_path, alert: 'Permission denied.'
        false
      end
    end

    def update_positions(old_pos = nil)
      @category.position = 1 if @category.position < 1
      all_categories = Category.where.not(id: @category.id)
      max_pos = all_categories.maximum(:position)
      new_pos = @category.position
      if new_pos > max_pos + 1
        new_pos = max_pos + 1
        @category.position = new_pos
      end
      updates = {}
      if old_pos
        if old_pos < new_pos
          categories = all_categories.where(position: (old_pos + 1)..new_pos)
          categories.each { |c| updates[c.id] = { position: c.position - 1 } }
        elsif new_pos < old_pos
          categories = all_categories.where(position: new_pos...old_pos)
          categories.each { |c| updates[c.id] = { position: c.position + 1 } }
        end
      elsif new_pos <= max_pos
        categories = all_categories.where(position: new_pos..max_pos)
        categories.each { |c| updates[c.id] = { position: c.position + 1 } }
      end
      Category.update(updates.keys, updates.values) if updates.any?
      @category.save!
    end
end
