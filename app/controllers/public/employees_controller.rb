class Public::EmployeesController < ApplicationController
  # before_action :ensure_correct_employee, only: [:edit, :update]
  
  def index
    @employees = Employee.includes(:department)
  end
  
  def show
    @employee = Employee.find(params[:id])
    if @employee == current_employee
      favorites = Favorite.where(employee_id: @employee).select(:post_id)
      @favorite_posts = Post.where(favorites)
    end
  end
  
  def edit
    @employee = Employee.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:id])
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
  
  # def ensure_correct_employee
  #   @employee = Employee.find(params[:id])
  #   unless @employee == current_employee
  #     redirect_to employee_path(@employee)
  #   end
  # end
  
end
