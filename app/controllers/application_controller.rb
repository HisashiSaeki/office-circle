class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :authenticate_employee!, except: [:top], unless: :admin_url
  
  def admin_url
    request.fullpath.include?("/admin")
  end
end
