class Public::ActivitiesController < ApplicationController
  
  def index
    @activities = current_employee.activities.order(created_at: :desc).page(params[:page]).per(20)
    @activities.where(checked: false).each { |activity| activity.update(checked: true) }
  end
  
  def destroy_all
    @activities = current_employee.activities.destroy_all
    redirect_to notifications_path
  end
end
