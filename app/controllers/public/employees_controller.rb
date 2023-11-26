class Public::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :ensure_correct_employee, only: [:edit, :update]

  def index
    @employees = Employee.includes(:department).order(created_at: "DESC").page(params[:page])
    @departments = Department.all
  end

  def show
    @my_articles = @employee.articles.order(created_at: "DESC")
    @favorite_articles = @employee.favorite_articles
    @groups = @employee.groups
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
    params.require(:employee).permit(
      :profile_image,
      :last_name,
      :first_name,
      :last_name_furigana,
      :first_name_furigana,
      :birthdate,
      :prefecture,
      :department_id,
      :introduction,
      :email,
      :is_active
    )
  end

  def ensure_correct_employee
    redirect_to employee_path(@employee) if @employee != current_employee || @employee.guest_employee?
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

end
