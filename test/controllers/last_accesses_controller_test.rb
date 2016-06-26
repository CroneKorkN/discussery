require 'test_helper'

class LastAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @last_access = last_accesses(:one)
  end

  test "should get index" do
    get last_accesses_url
    assert_response :success
  end

  test "should get new" do
    get new_last_access_url
    assert_response :success
  end

  test "should create last_access" do
    assert_difference('LastAccess.count') do
      post last_accesses_url, params: { last_access: { time: @last_access.time, topic_id: @last_access.topic_id, user_id: @last_access.user_id } }
    end

    assert_redirected_to last_access_url(LastAccess.last)
  end

  test "should show last_access" do
    get last_access_url(@last_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_last_access_url(@last_access)
    assert_response :success
  end

  test "should update last_access" do
    patch last_access_url(@last_access), params: { last_access: { time: @last_access.time, topic_id: @last_access.topic_id, user_id: @last_access.user_id } }
    assert_redirected_to last_access_url(@last_access)
  end

  test "should destroy last_access" do
    assert_difference('LastAccess.count', -1) do
      delete last_access_url(@last_access)
    end

    assert_redirected_to last_accesses_url
  end
end
