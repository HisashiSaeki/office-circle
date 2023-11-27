class Public::GroupMembersController < ApplicationController
  before_action :set_group
  
  def create
    group_member = current_employee.group_members.new(group_id: @group.id)
    redirect_back fallback_location: groups_path, notice: "グループに参加しました" if group_member.save
  end
  
  def destroy
    group_member = current_employee.group_members.find_by(group_id: @group.id)
    redirect_back fallback_location: groups_path, notice: "グループから退会しました" if group_member.destroy
  end
  
  
  private
  
  
  def set_group
    @group = Group.find(params[:group_id])
  end
end
