class Admin::DepartmentsController < ApplicationController
  before_action :set_department, only: [:edit, :update]
  
  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_back fallback_location: admin_employees_path, notice: "部署の登録が完了しました"
    else
      render :index
    end
  end
  
  def index
    @department = Department.new
    @departments = Department.all
  end
  
  def edit
  end
  
  def update
    if @department.update(department_params)
      redirect_to admin_departments_path, notice: "部署名の変更が完了しました"
    else
      render :edit
    end
  end

  
  private
  
  
  def department_params
    params.require(:department).permit(:name)
  end
  
  def set_department
    @department = Department.find(params[:id])
  end
end
