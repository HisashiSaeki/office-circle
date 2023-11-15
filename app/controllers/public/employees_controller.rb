class Public::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :ensure_correct_employee, only: [:edit, :update]

  def index
    @employees = Employee.includes(:department)
    @departments = Department.all
  end

  def show
    @my_articles = Article.where(employee_id: @employee).includes(:tags).order(created_at: "DESC")
    @favorite_articles = @employee.favorite_articles.includes(:tags)
    @groups = @employee.groups.includes(:creater).page(params[:page])
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: "登録内容の変更が完了しました"
    else
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:last_name, :first_name, :last_name_furigana, :first_name_furigana, :birthdate, :prefecture, :department_id, :introduction, :email, :is_active)
  end

  def ensure_correct_employee
    if @employee != current_employee
      redirect_to employee_path(@employee)
    end
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

end
