class Admin::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  
  def index
    @employees = Employee.includes(:department)
    @departments = Department.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @employee.update(employee_params)
      redirect_to admin_employee_path(@employee), notice: "登録情報の更新が完了しました"
    else
      render :edit
    end
  end
  
  private
  
  def employee_params
    params.require(:employee).permit(:last_name, :first_name, :last_name_furigana, :first_name_furigana, :birthdate, :prefecture, :department_id, :introduction, :email, :is_active)
  end
  
  def set_employee
    @employee = Employee.find(params[:id])
  end
end
