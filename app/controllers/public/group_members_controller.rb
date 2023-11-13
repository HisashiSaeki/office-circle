class Public::GroupMembersController < ApplicationController
  before_action :set_group
  
  def create
    group_member = current_employee.group_members.new(group_id: @group.id)
    group_member.save
    flash[:notice] = "グループに参加しました"
    redirect_back fallback_location: groups_path
  end
  
  def destroy
    group_member = current_employee.group_members.find_by(group_id: @group.id)
    group_member.destroy
    flash[:notice] = "グループから退会しました"
    redirect_back fallback_location: groups_path
  end
  
  
  private
  
  
  def set_group
    @group = Group.find(params[:group_id])
  end
end
