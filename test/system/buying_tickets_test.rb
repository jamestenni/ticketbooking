require "application_system_test_case"

class BuyingTicketsTest < ApplicationSystemTestCase
  setup do
    @user_test_login_1 = users(:user_test_login_1)
    @movie_test_1 = movies(:movie_test_1)
    @movie_test_2 = movies(:movie_test_2)
    @timetable_test_1 = timetables(:timetable_test_1)
  end

  test "visit main page (without login) and observe movie lists" do
    visit main_page_url
    assert_selector "#NowShowingTitle", text: "Now showing"

    # Since movie test 2 date in come later, it should be displayed first
    find("#MovieTable").find("td:first-child").assert_text @movie_test_2.name
    find("#MovieTable").find("td:first-child").assert_text @movie_test_2.get_date_in
    find("#MovieTable").find("td:first-child").assert_text @movie_test_2.movie_type
    find("#MovieTable").find("td:first-child").assert_text "#{@movie_test_2.duration} min"

    find("#MovieTable").find("td:nth-child(2)").assert_text @movie_test_1.name
    find("#MovieTable").find("td:nth-child(2)").assert_text @movie_test_1.get_date_in
    find("#MovieTable").find("td:nth-child(2)").assert_text @movie_test_1.movie_type
    find("#MovieTable").find("td:nth-child(2)").assert_text "#{@movie_test_1.duration} min"
  end

  test "visit main page (without login) and observe movie_test_1 timetable" do
    visit main_page_url
    # date begin on 20-26 Dec 2021
    # select movie_test_1 --> There is no showtime in Dec 20 
    find("#MovieTable").find("td:nth-child(2)").click
    assert_text @movie_test_1.name
    assert_text "--- No Showtime Available ---"

    # click on Dec 21
    find("#pills-tab").find("li:nth-child(2)").find("button").click
    assert_text "Theater: #{@timetable_test_1.theater.number} - #{@timetable_test_1.theater.name}"
    assert_text @timetable_test_1.get_show_time

    find("div.theaterBox > div > div > div").click
    assert_current_path "/movie/#{@movie_test_1.id}/showtime/#{@timetable_test_1.id}"
  end

  test "visit selectseat page (without login)" do
    visit select_seat_page_url(s_id: @timetable_test_1.id, m_id: @timetable_test_1.movie.id)
    assert_text @timetable_test_1.movie.description

    # at start price = 0 THB
    assert_equal(0, find("#priceLabel").value.to_i) 

    # choose seat D2 and D3 (standard one), also A4 (premium one)
    within("#seatTable") do
      find("tr:first-child").find("td:nth-child(3)").find("input:nth-child(2)", :visible => false).click
      find("tr:first-child").find("td:nth-child(4)").find("input:nth-child(2)", :visible => false).click
      find("tr:nth-child(4)").find("td:nth-child(5)").find("input:nth-child(2)", :visible => false).click
    end
    find("#priceLabel").assert_text "500"

    assert_text "You need to login to proceed"
  end

  test "visit selectseat page (login) but not selecting any seat" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username
      fill_in "Password", with: "123456"
      click_on "Login"
    end
    within("nav") do
      assert_text "Welcome"
      assert_text @user_test_login_1.firstname
    end
    visit select_seat_page_url(s_id: @timetable_test_1.id, m_id: @timetable_test_1.movie.id)
    assert_text @timetable_test_1.movie.description

    within("#submitContainer") do
      find("input").click
    end
    assert_text "You haven't pick any seat, please pick one to proceed"
  end



  test "visit selectseat page (login) selecting seats and goto order summary page and then press cancel" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username
      fill_in "Password", with: "123456"
      click_on "Login"
    end
    visit select_seat_page_url(s_id: @timetable_test_1.id, m_id: @timetable_test_1.movie.id)

    # at start price = 0 THB
    assert_equal(0, find("#priceLabel").value.to_i) 

    # choose seat D2 and D3 (standard one), also A4 (premium one)
    within("#seatTable") do
      find("tr:first-child").find("td:nth-child(3)").find("input:nth-child(2)", :visible => false).click
      find("tr:first-child").find("td:nth-child(4)").find("input:nth-child(2)", :visible => false).click
      find("tr:nth-child(4)").find("td:nth-child(5)").find("input:nth-child(2)", :visible => false).click
    end
    find("#priceLabel").assert_text "500"

    within("#submitContainer") do
      find("input").click
    end

    assert_text "Order Summary"
    page.assert_selector('#ticketItemListContainer .ticketItemContainer', :count => 3) #3 ticket in order summary

    within("#ticketItemListContainer .ticketItemContainer:first-child") do
      assert_selector "h4", text: @timetable_test_1.movie.name
      find("#dateBox p:first-child").assert_text @timetable_test_1.get_show_date
      find("#timeBox p:first-child").assert_text @timetable_test_1.get_show_time
    end
    find("#priceLabel").assert_text "500"

    # click cancel order
    find("input.custom-button.cancel").click
    assert_text "Your order has been canceled"
    assert_current_path "/movie/#{@movie_test_1.id}/showtime/#{@timetable_test_1.id}"

    click_on "Inventory"
    assert_text "... You don't have any tickets ..."
  end


  test "success buying tickets" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username
      fill_in "Password", with: "123456"
      click_on "Login"
    end
    visit select_seat_page_url(s_id: @timetable_test_1.id, m_id: @timetable_test_1.movie.id)

    # choose seat D2 and D3 (standard one), also A4 (premium one)
    within("#seatTable") do
      find("tr:first-child").find("td:nth-child(3)").find("input:nth-child(2)", :visible => false).click
      find("tr:first-child").find("td:nth-child(4)").find("input:nth-child(2)", :visible => false).click
      find("tr:nth-child(4)").find("td:nth-child(5)").find("input:nth-child(2)", :visible => false).click
    end

    within("#submitContainer") do
      find("input").click
    end

    #click confirm order
    find("input.custom-button.confirm").click
    assert_text "Your order is completed."
    
    #go to inventory
    find("#goInventoryButton").click
    assert_text "Inventory"
    page.assert_selector('#ticketItemListContainer .ticketItemContainer', :count => 3) #3 tickets in inventory

    within("#ticketItemListContainer .ticketItemContainer:first-child") do
      assert_selector "h4", text: @timetable_test_1.movie.name
      find("#dateBox p:first-child").assert_text @timetable_test_1.get_show_date
      find("#timeBox p:first-child").assert_text @timetable_test_1.get_show_time
    end
  end

end
