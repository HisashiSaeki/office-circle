class Public::SearchesController < ApplicationController
  before_action :set_keyword, only: [:employees_search, :articles_search, :groups_search]
  before_action :set_tags, only: [:articles_search, :tag_search]
  before_action :set_departments, only: [:employees_search, :department_search]

  def employees_search
      @employees = Employee.search(@keyword).includes(:department).order(created_at: "DESC").page(params[:page])
  end
  
  def articles_search
    @articles = Article.search(@keyword).is_published_articles.order(created_at: "DESC").page(params[:page])
  end
  
  def groups_search
    @groups = Group.search(@keyword).order(created_at: "DESC").page(params[:page])
  end

  def department_search
    @employees = Department.find(params[:department_id]).employees.page(params[:page])
  end

  def tag_search
    @articles = Tag.find(params[:tag_id]).articles.is_published_articles.page(params[:page])
  end
  
  
  private
  
  
  def set_keyword 
    @keyword = params[:keyword]
  end
  
  def set_tags 
    @tags = Tag.is_published_article_tags
  end
  
  def set_departments
    @departments = Department.all
  end
end
