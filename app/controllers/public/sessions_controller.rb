# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :employee_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  def guest_sign_in
    employee = Employee.guest
    sign_in employee
    redirect_to employee_path(employee), notice: "guestuserでログインしました。"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    employee_path(resource)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def employee_state
    employee = Employee.find_by(email: params[:employee][:email])
    return if !employee
    return unless employee.valid_password?(params[:employee][:password])
    if !employee.is_active
      flash[:notice] = "アカウント停止中です。管理者にご連絡ください。"
      redirect_to root_path
    end
  end
  
end
