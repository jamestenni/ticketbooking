require "test_helper"

class OrderlineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orderline_item = orderline_items(:one)
  end

  test "should get index" do
    get orderline_items_url
    assert_response :success
  end

  test "should get new" do
    get new_orderline_item_url
    assert_response :success
  end

  test "should create orderline_item" do
    assert_difference('OrderlineItem.count') do
      post orderline_items_url, params: { orderline_item: { order_id: @orderline_item.order_id, price: @orderline_item.price, product_id: @orderline_item.product_id, quantity: @orderline_item.quantity } }
    end

    assert_redirected_to orderline_item_url(OrderlineItem.last)
  end

  test "should show orderline_item" do
    get orderline_item_url(@orderline_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_orderline_item_url(@orderline_item)
    assert_response :success
  end

  test "should update orderline_item" do
    patch orderline_item_url(@orderline_item), params: { orderline_item: { order_id: @orderline_item.order_id, price: @orderline_item.price, product_id: @orderline_item.product_id, quantity: @orderline_item.quantity } }
    assert_redirected_to orderline_item_url(@orderline_item)
  end

  test "should destroy orderline_item" do
    assert_difference('OrderlineItem.count', -1) do
      delete orderline_item_url(@orderline_item)
    end

    assert_redirected_to orderline_items_url
  end
end
