class MainController < ApplicationController
  def index
    @main_products = MainProduct.all
  end

  def about
  end

  def thank
  end
end
