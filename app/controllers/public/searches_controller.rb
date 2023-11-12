class Public::SearchesController < ApplicationController
  
  def keyword_search
    if params[:employee].present?
      @employees = Employee.search(params[:keyword]).includes(:department)
    elsif params[:article].present?
      @articles = Article.search(params[:keyword])
    elsif params[:group].present?
      @groups = Group.search(params[:keyword])
    end
    @keyword = params[:keyword]
  end
  
  def department_search
    @employees = Employee.where(department_id: params[:department_id]).includes(:department)
  end
  
  def tag_search
  end
  
end
