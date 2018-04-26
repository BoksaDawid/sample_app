require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
 def setup
   @user = users(:michael)
   @non_admin = users(:david)
 end
 test "index include pagination" do
  log_in_as(@user)
  get users_path
  assert_template 'users/index'
  assert_select 'div.pagination', count: 2
  User.where(activated: true).paginate(page: 1).each do |user|
    user.activated?
    assert_select 'a[href=?]', user_path(user), text: user.name
  end
 end
 test "index as non-admin" do
  log_in_as(@non_admin)
  get users_path
  assert_select 'a', text: 'delete', count: 0
end
end
