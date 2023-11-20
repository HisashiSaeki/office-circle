class Public::SearchesController < ApplicationController
  before_action :set_keyword, only: [:employees_search, :articles_search, :groups_search]
  before_action :set_tags, only: [:articles_search, :tag_search]

  def employees_search
      @employees = Employee.search(params[:keyword]).includes(:department).order(created_at: "DESC")
  end
  
  def articles_search
    @articles = Article.search(params[:keyword]).where(is_published: true).includes(:employee, :tags, :favorites, :comments).order(created_at: "DESC")
  end
  
  def groups_search
    @groups = Group.search(params[:keyword]).order(created_at: "DESC")
  end

  def department_search
    @employees = Employee.where(department_id: params[:department_id]).includes(:department).order(created_at: "DESC")
  end

  def tag_search
    @articles = Tag.find(params[:tag_id]).articles.where(is_published: true).includes(:employee, :tags, :favorites, :comments).order(created_at: "DESC")
  end
  
  
  private
  
  
  def set_keyword 
    @keyword = params[:keyword]
  end
  
  def set_tags
    tag_list = ArticleTag.pluck(:tag_id)
    @tags = Tag.where(id: tag_list)
  end
end
