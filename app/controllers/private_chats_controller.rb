class PrivateChatsController < ApplicationController
  def show
    @group = find_chat || create_chat
    @chat_partner = User.find params[:user_id]
  end
  
  private
  
  def find_chat
    Group.find_by(name: name(current_user.id, params[:user_id])) ||
    Group.find_by(name: name(params[:user_id], current_user.id))
  end
  
  def create_chat
    Group.create(name: name(current_user.id, params[:user_id]))
  end
  
  def name uid_a, uid_b
    "PRIVATE_CHAT_#{uid_a}_#{uid_b}"
  end
end