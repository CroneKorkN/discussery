require 'test_helper'

class PrivateChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @private_chat = private_chats(:one)
  end

  test "should get index" do
    get private_chats_url
    assert_response :success
  end

  test "should get new" do
    get new_private_chat_url
    assert_response :success
  end

  test "should create private_chat" do
    assert_difference('PrivateChat.count') do
      post private_chats_url, params: { private_chat: {  } }
    end

    assert_redirected_to private_chat_url(PrivateChat.last)
  end

  test "should show private_chat" do
    get private_chat_url(@private_chat)
    assert_response :success
  end

  test "should get edit" do
    get edit_private_chat_url(@private_chat)
    assert_response :success
  end

  test "should update private_chat" do
    patch private_chat_url(@private_chat), params: { private_chat: {  } }
    assert_redirected_to private_chat_url(@private_chat)
  end

  test "should destroy private_chat" do
    assert_difference('PrivateChat.count', -1) do
      delete private_chat_url(@private_chat)
    end

    assert_redirected_to private_chats_url
  end
end
