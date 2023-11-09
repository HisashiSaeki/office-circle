class Public::ArticlesController < ApplicationController
  before_action :ensure_correct_employee, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.employee_id = current_employee.id
    # if @article.save(article_params)
      
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
    if @article.save(article_params)
      redirect_to article_path(@article), notice: "投稿内容の変更が完了しました"
    end
  end
  
  def destroy
    if @article.destroy
      redirect_to articles_path, notice: "投稿内容の削除が完了しました"
    end
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body, :employee_id, :is_published)
  end
  
  def ensure_correct_employee
    @article = Article.find(params[:id])
    unless @post.employee == current_employee
      redirect_to article_path(@article)
    end
  end
  
end
