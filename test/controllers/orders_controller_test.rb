require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @order = orders(:one)
    @user = users(:one)
    @provider = users(:two)
  end

  test "should get index" do
    sign_in @user
    get :index, user_id: @user.id
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    sign_in @user
    get :new, provider_id: @user.id
    assert_response :success
  end

  test "should create order" do
    sign_in @user
    assert_difference('Order.count') do
      post :create, provider_id: @provider.id, order: { date: '01/01/2017', description: 'descripción', information: 'información', provider_id: @provider.id }
    end

    assert_redirected_to provider_order_path(@provider.id, assigns(:order))
  end

  test "should show order" do
    sign_in @user
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @order, provider_id: @provider.id
    assert_response :success
  end

  test "should update order" do
    sign_in @user
    patch :update, id: @order, provider_id: @provider.id, order: { date: '01/01/2017', description: 'descripción', information: 'información' }
    assert_redirected_to user_orders_path(@user.id)
  end

  test "should destroy order" do
    sign_in @user
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order, user_id: @user.id
    end

    assert_redirected_to user_orders_path
  end
end
