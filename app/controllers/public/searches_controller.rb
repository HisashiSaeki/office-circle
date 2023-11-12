class Public::SearchesController < ApplicationController
  before_action :set_keyword, only: [:employees_search, :articles_search, :groups_search]

  def employees_search
      @employees = Employee.search(params[:keyword]).includes(:department)
  end
  
  def articles_search
    @articles = Article.search(params[:keyword]).where(is_published: true).includes(:employee, :tags, :favorites, :comments).order(created_at: "DESC")
  end
  
  def groups_search
    @groups = Group.search(params[:keyword])
  end

  def department_search
    @employees = Employee.where(department_id: params[:department_id]).includes(:department)
  end

  def tag_search
    @articles = Tag.find(params[:tag_id]).articles.where(is_published: true).includes(:employee, :tags, :favorites, :comments).order(created_at: "DESC")
  end
  
  private
  
  def set_keyword 
    @keyword = params[:keyword]
  end

end
