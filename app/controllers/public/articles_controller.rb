class Public::ArticlesController < ApplicationController
  before_action :ensure_correct_employee, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_employee.articles.new(article_params)
    @article.is_published = params[:article][:is_published]
    if @article.is_published == true
      @article.save
      redirect_to articles_path
    elsif @article.is_published == false
      @article.save
      redirect_to employee_path(current_employee)
    else
      render :new
    end
  end
  
  def index
    @articles = Article.where(is_published: true).includes(:employee, :tags, :favorites, :comments)
  end
  
  def show
    @article = Article.find(params[:id])
    @comments = Comment.where(article_id: @article).includes(:employee)
    @comment = Comment.new
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "投稿内容の変更が完了しました"
    else
      render :edit
    end
  end
  
  def destroy
    if @article.destroy
      redirect_to articles_path, notice: "投稿内容の削除が完了しました"
    end
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
  def ensure_correct_employee
    @article = Article.find(params[:id])
    unless @article.employee == current_employee
      redirect_to article_path(@article)
    end
  end
  
end
