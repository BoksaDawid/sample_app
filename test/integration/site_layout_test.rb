require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

test "layout links" do
  get root_path
  assert_template 'static_pages/home'
  assert_select "a[href=?]", root_path, count: 2
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", about_path
  assert_select "a[href=?]", contact_path
  assert_select "a[href=?]", signup_path
  get contact_path
  assert_select "title", full_title("Contact")
  get signup_path
  assert_select "title", full_title("Sign up")
end

test "layout links as logged user" do
 log_in_as(users(:michael))
 get root_path
 assert_select "a[href=?]", logout_path
 assert_select "a[href=?]", users_path
 assert_select "a[href=?]", edit_user_path(users(:michael))
 assert_select "a[href=?]", user_path(users(:michael))
end
test "layout links as not logged user" do
 get root_path
 assert_select "a[href=?]", logout_path, count: 0
 assert_select "a[href=?]", users_path, count: 0
 assert_select "a[href=?]", edit_user_path(users(:michael)), count: 0
 assert_select "a[href=?]", user_path(users(:michael)), count: 0
end
end
