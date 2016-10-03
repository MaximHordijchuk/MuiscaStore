require 'test_helper'

class MainProductsControllerTest < ActionController::TestCase
  setup do
    @main_product = main_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:main_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create main_product" do
    assert_difference('MainProduct.count') do
      post :create, main_product: { product_id: @main_product.product_id }
    end

    assert_redirected_to main_product_path(assigns(:main_product))
  end

  test "should show main_product" do
    get :show, id: @main_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @main_product
    assert_response :success
  end

  test "should update main_product" do
    patch :update, id: @main_product, main_product: { product_id: @main_product.product_id }
    assert_redirected_to main_product_path(assigns(:main_product))
  end

  test "should destroy main_product" do
    assert_difference('MainProduct.count', -1) do
      delete :destroy, id: @main_product
    end

    assert_redirected_to main_products_path
  end
end
