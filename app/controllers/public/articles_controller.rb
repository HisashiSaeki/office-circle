class Public::ArticlesController < ApplicationController
  
  def new
    @article = article.new
  end
  
  def create
    @article = article.new(article_params)
    @article.employee_id = current_employee.id
    # if @article.save(article_params)
      
  end
  
  def index
    @articles = article.where(is_published: true).incluedes(:employee, :tags, :favorites, :comments)
  end
  
  def show
    @article = article.find(params[:id])
    @comments = Comment.where(article_id: @article).includes(:employee)
  end
  
  def edit
    @article = article.find(params[:id])
  end
  
  def update
    @article = article.find(params[:id])
    @article.save(article_params)
  end
  
  def destroy
    @article = article.find(params[:id])
    @article.destroy
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body, :employee_id, :is_published)
  end
  
end
