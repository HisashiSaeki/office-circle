class Public::GroupMembersController < ApplicationController
  
  def create
    group_member = current_employee.group_members.new(group_id: @group.id)
    group_member.save
    flash[:notice] = "グループに参加しました"
  end
  
  def destroy
    group_member = current_employee.group_members.find_by(group_id: @group.id)
    group_member.destroy
    flash[:notice] = "グループから退会しました"
  end
  
  
  private
  
  
  def set_group
    @group = Group.find(params[:id])
  end
end
