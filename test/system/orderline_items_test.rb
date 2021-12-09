require "application_system_test_case"

class OrderlineItemsTest < ApplicationSystemTestCase
  setup do
    @orderline_item = orderline_items(:one)
  end

  test "visiting the index" do
    visit orderline_items_url
    assert_selector "h1", text: "Orderline Items"
  end

  test "creating a Orderline item" do
    visit orderline_items_url
    click_on "New Orderline Item"

    fill_in "Order", with: @orderline_item.order_id
    fill_in "Price", with: @orderline_item.price
    fill_in "Product", with: @orderline_item.product_id
    fill_in "Quantity", with: @orderline_item.quantity
    click_on "Create Orderline item"

    assert_text "Orderline item was successfully created"
    click_on "Back"
  end

  test "updating a Orderline item" do
    visit orderline_items_url
    click_on "Edit", match: :first

    fill_in "Order", with: @orderline_item.order_id
    fill_in "Price", with: @orderline_item.price
    fill_in "Product", with: @orderline_item.product_id
    fill_in "Quantity", with: @orderline_item.quantity
    click_on "Update Orderline item"

    assert_text "Orderline item was successfully updated"
    click_on "Back"
  end

  test "destroying a Orderline item" do
    visit orderline_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Orderline item was successfully destroyed"
  end
end
