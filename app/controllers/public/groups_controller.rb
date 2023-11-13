class Public::GroupsController < ApplicationController
  before_action :ensure_correct_creater, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creater_id = current_employee.id
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end

  end

  def index
    @groups = Group.includes(:employees)
  end

  def show
    @group = Group.find(params[:id])
    @employees = @group.employees.includes(:department)
    @notices = Notice.where(group_id: @group.id)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end


  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def ensure_correct_creater
    @group = Group.find(params[:id])
    unless @group.is_created_by?(current_employee)
      redirect_to group_path(@group)
    end
  end

end
