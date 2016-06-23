require 'test_helper'

class GroupGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_group = group_groups(:one)
  end

  test "should get index" do
    get group_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_group_group_url
    assert_response :success
  end

  test "should create group_group" do
    assert_difference('GroupGroup.count') do
      post group_groups_url, params: { group_group: { group_id: @group_group.group_id, member_group_id: @group_group.member_group_id } }
    end

    assert_redirected_to group_group_url(GroupGroup.last)
  end

  test "should show group_group" do
    get group_group_url(@group_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_group_url(@group_group)
    assert_response :success
  end

  test "should update group_group" do
    patch group_group_url(@group_group), params: { group_group: { group_id: @group_group.group_id, member_group_id: @group_group.member_group_id } }
    assert_redirected_to group_group_url(@group_group)
  end

  test "should destroy group_group" do
    assert_difference('GroupGroup.count', -1) do
      delete group_group_url(@group_group)
    end

    assert_redirected_to group_groups_url
  end
end
