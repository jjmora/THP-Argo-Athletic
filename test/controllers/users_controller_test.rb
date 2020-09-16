require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :notice
  end

  test "should get show" do
    get users_show_url
    assert_response :notice
  end

end
