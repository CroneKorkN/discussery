require 'test_helper'

class RoleScopesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_scope = role_scopes(:one)
  end

  test "should get index" do
    get role_scopes_url
    assert_response :success
  end

  test "should get new" do
    get new_role_scope_url
    assert_response :success
  end

  test "should create role_scope" do
    assert_difference('RoleScope.count') do
      post role_scopes_url, params: { role_scope: { group_id: @role_scope.group_id, role_id: @role_scope.role_id, scopable_id: @role_scope.scopable_id, scopable_type: @role_scope.scopable_type } }
    end

    assert_redirected_to role_scope_url(RoleScope.last)
  end

  test "should show role_scope" do
    get role_scope_url(@role_scope)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_scope_url(@role_scope)
    assert_response :success
  end

  test "should update role_scope" do
    patch role_scope_url(@role_scope), params: { role_scope: { group_id: @role_scope.group_id, role_id: @role_scope.role_id, scopable_id: @role_scope.scopable_id, scopable_type: @role_scope.scopable_type } }
    assert_redirected_to role_scope_url(@role_scope)
  end

  test "should destroy role_scope" do
    assert_difference('RoleScope.count', -1) do
      delete role_scope_url(@role_scope)
    end

    assert_redirected_to role_scopes_url
  end
end
