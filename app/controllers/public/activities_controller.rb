class Public::ActivitiesController < ApplicationController

  def index
    @activities = current_employee.activities.includes(subject: :article).order(created_at: "DESC")
    @activities.where(checked: false).update_all(checked: true)
  end

  def destroy_all
    @activities = current_employee.activities.destroy_all
    redirect_to activities_path
  end
end
