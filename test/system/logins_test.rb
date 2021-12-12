require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  setup do
    @user_test_login_1 = users(:user_test_login_1)
  end

  test "visit login page directly through URL" do
    visit login_page_url
    assert_selector "h3", text: "Login"
  end

  test "visit login page via main page" do
    visit main_page_url
    click_on "Login"
    assert_selector "h3", text: "Login"
  end

  test "user_test_login_1 login with correct password" do
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
  end

  test "user_test_login_1 login with wrong password" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username
      fill_in "Password", with: "654321"
      click_on "Login"
      assert_text "Your email or password is incorrect!"
    end
  end

  test "user_test_login_1 login with wrong username" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username + "xxx"
      fill_in "Password", with: "123456"
      click_on "Login"
      assert_text "Your email or password is incorrect!"
    end
  end

  test "user_test_login_1 login but not enter password" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Username", with: @user_test_login_1.username
      click_on "Login"
      assert_text "Your email or password is incorrect!"
    end
  end

  test "user_test_login1 login but not enter usernamne" do
    visit login_page_url
    within(".centerCard") do
      fill_in "Password", with: "123456"
      click_on "Login"
      assert_text "Your email or password is incorrect!"
    end
  end

  test "user_test_login1 login but not enter anything" do
    visit login_page_url
    within(".centerCard") do
      click_on "Login"
      assert_text "Your email or password is incorrect!"
    end
  end
end
