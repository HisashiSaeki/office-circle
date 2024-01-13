class Public::GroupsController < ApplicationController
  before_action :ensure_correct_creater, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creater_id = current_employee.id
    @group.save ? (redirect_to group_path(@group), notice: "グループを作成しました") : (render :new)
  end

  def index
    @groups = Group.includes(:creater).order(created_at: "DESC").page(params[:page])
  end

  def show
    @group = Group.includes(:notices, :employees).find(params[:id])
  end

  def edit
  end

  def update
    @group.update(group_params) ? (redirect_to group_path(@group), notice: "グループの変更が完了しました") : (render :edit)
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end


  private


  def group_params
    params.require(:group).permit(:name, :description)
  end

  def ensure_correct_creater
    @group = Group.find(params[:id])
    redirect_to group_path(@group) unless @group.created_by?(current_employee)
  end

end
