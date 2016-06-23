require 'test_helper'

class GroupRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_role = group_roles(:one)
  end

  test "should get index" do
    get group_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_group_role_url
    assert_response :success
  end

  test "should create group_role" do
    assert_difference('GroupRole.count') do
      post group_roles_url, params: { group_role: { category_id: @group_role.category_id, group_id: @group_role.group_id, recursive: @group_role.recursive, role_id: @group_role.role_id } }
    end

    assert_redirected_to group_role_url(GroupRole.last)
  end

  test "should show group_role" do
    get group_role_url(@group_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_role_url(@group_role)
    assert_response :success
  end

  test "should update group_role" do
    patch group_role_url(@group_role), params: { group_role: { category_id: @group_role.category_id, group_id: @group_role.group_id, recursive: @group_role.recursive, role_id: @group_role.role_id } }
    assert_redirected_to group_role_url(@group_role)
  end

  test "should destroy group_role" do
    assert_difference('GroupRole.count', -1) do
      delete group_role_url(@group_role)
    end

    assert_redirected_to group_roles_url
  end
end
