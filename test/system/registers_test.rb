require "application_system_test_case"

class RegistersTest < ApplicationSystemTestCase
  test "visit register page directly through URL" do
    visit register_page_url
    assert_selector "h3", text: "Register"
  end

  test "register via main page" do
    visit main_page_url
    click_on "Register"
    assert_selector "h3", text: "Register"
    within(".centerCard") do
      fill_in "Username", with: "a"
      click_on "Register"
      assert_text "Username is too short (minimum is 4 characters)"

      fill_in "Username", with: "user_test_login_1"
      click_on "Register"
      assert_text "Username has already been taken"

      fill_in "Username", with: "test3"
      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "654321"
      click_on "Register"
      assert_text "Password confirmation doesn't match Password"

      fill_in "Password", with: "12345"
      fill_in "Password confirmation", with: "12345"
      fill_in "Password confirmation", with: "12345"
      click_on "Register"
      assert_text "Password is too short (minimum is 6 characters)"

      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      fill_in "Firstname", with: "test_register_firstname"
      fill_in "Lastname", with: "test_register_lastname"
      fill_in "Email", with: "mymail"
      # Select birthdate----------------------------------------------------
      find(:css, "#user_birthdate_3i").find(:option, "27").select_option
      find(:css, "#user_birthdate_2i").find(:option, "December").select_option
      find(:css, "#user_birthdate_1i").find(:option, "2000").select_option  
      # --------------------------------------------------------------------
      click_on "Register"
      assert_text "Email is invalid"

      fill_in "Password", with: "123456"
      fill_in "Password confirmation", with: "123456"
      fill_in "Firstname", with: "test_register_firstname"
      fill_in "Lastname", with: "test_register_lastname"
      fill_in "Email", with: "test3@hotmail.com"
      # Select birthdate----------------------------------------------------
      find(:css, "#user_birthdate_3i").find(:option, "27").select_option
      find(:css, "#user_birthdate_2i").find(:option, "December").select_option
      find(:css, "#user_birthdate_1i").find(:option, "2000").select_option  
      # --------------------------------------------------------------------
      click_on "Register"
    end
    within(".centerCard") do
      assert_text "Registration completed! Now you can login to buy some tickets!"
      fill_in "Username", with: "test3"
      fill_in "Password", with: "123456"
      click_on "Login"
    end
    within("nav") do
      assert_text "Welcome"
      assert_text "test_register_firstname"
    end
  end
end
