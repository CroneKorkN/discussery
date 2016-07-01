class PrivateChatsController < ApplicationController
  def show
    raise "diskussery: can`t messege yourself!" if params[:user_id].to_i == current_user.id
    @chat_partner = User.find params[:user_id]
    unless @group = Group.find_by(name: name)
      @group = Group.create(name: name)
      @group.has_members.create member_id: params[:user_id], member_type: "User"
      @group.has_members.create member_id: current_user.id, member_type: "User"
    end
  end
  
  private
  
  def name
    ids = [current_user.id, params[:user_id].to_i].sort
    "PRIVATE_CHAT_#{ids[0]}_#{ids[1]}"
  end
  
  def private_chat_user
    User.find Setting[:private_chat_user_id]
  end
end