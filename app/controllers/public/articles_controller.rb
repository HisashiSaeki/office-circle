class Public::ArticlesController < ApplicationController
  before_action :ensure_correct_employee, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_employee.articles.new(article_params)
    list_tags = params[:article][:tag].split("、")
    if params[:post].present?
      @article.is_published = true
      if @article.save
        @article.save_tags(list_tags)
        redirect_to article_path(@article), notice: "投稿完了しました"
      end
    elsif params[:draft].present?
      @article.is_published = false
      if @article.save
        @article.save_tags(list_tags)
        redirect_to article_path(@article), notice: "投稿を下書き保存しました"
      end
    else
      render :new
    end
  end
  
  def index
    @articles = Article.where(is_published: true).includes(:employee, :tags, :favorites, :comments).order(created_at: "DESC")
  end
  
  def show
    @article = Article.find(params[:id])
    if @article.is_published == false && @article.employee != current_employee
      redirect_to articles_path
    else
      @comments = Comment.where(article_id: @article).includes(:employee)
      @comment = Comment.new
    end
  end
  
  def edit
    @tag_list = @article.tags.pluck(:name).join('、')
  end
  
  def update
    list_tags = params[:article][:tag].split("、")
    if params[:post].present?
      @article.is_published = true
      if @article.update(article_params)
        @article.update_tags(list_tags)
      end
    elsif params[:draft].present?
      @article.is_published = false
      if @article.update(article_params)
        @article.update_tags(list_tags)
      end
    else
      render :edit
    end
    redirect_to article_path(@article), notice: "投稿内容の変更が完了しました"
  end
  
  def destroy
    if @article.destroy
      redirect_to articles_path, notice: "投稿内容の削除が完了しました"
    end
  end
  
  private
  
  def article_params = params.require(:article).permit(:title, :body)
  
  def ensure_correct_employee
    @article = Article.find(params[:id])
    if @article.employee != current_employee
      redirect_to article_path(@article)
    end
  end
  
  
  
end
