require 'test_helper'

class ItemSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get item_sessions_create_url
    assert_response :success
  end

  test "should get update" do
    get item_sessions_update_url
    assert_response :success
  end

  test "should get index" do
    get item_sessions_index_url
    assert_response :success
  end

  test "should get show" do
    get item_sessions_show_url
    assert_response :success
  end

end
