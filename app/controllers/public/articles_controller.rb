class Public::ArticlesController < ApplicationController
  before_action :ensure_correct_employee, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = current_employee.articles.new(article_params)
    list_tags = params[:article][:tag].split("、").uniq
    if params[:post].present?
      if @article.save_published
        @article.save_tags(list_tags)
        redirect_to article_path(@article), notice: "記事を投稿しました"
      else
        render :new
      end
    elsif params[:draft].present?
      if @article.save_private
        @article.save_tags(list_tags)
        redirect_to article_path(@article), notice: "投稿を下書き保存しました"
      else
        render :new
      end
    else
      render :new
    end
  end

  def index
    @articles = Article.is_published_articles.order(created_at: "DESC").page(params[:page])
    @tags = Tag.published_article_tags
  end

  def show
    @article = Article.includes(:comments).find(params[:id])
    redirect_to articles_path if !@article.is_published && !@article.created_by?(current_employee)
    @comment = Comment.new
  end

  def edit
    @tag_list = @article.join_tags
  end

  def update
    list_tags = params[:article][:tag].split("、").uniq
    if params[:post].present?
      if @article.update_published(article_params)
        @article.update_tags(list_tags)
        redirect_to article_path(@article), notice: "投稿内容の変更が完了しました"
      else
        @tag_list = @article.join_tags
        render :edit
      end
    else
      if @article.update_private(article_params)
        @article.update_tags(list_tags)
        redirect_to article_path(@article), notice: "投稿内容の変更が完了しました"
      else
        @tag_list = @article.join_tags
        render :edit
      end
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "投稿内容の削除が完了しました"
  end


  private


  def article_params 
    params.require(:article).permit(:title, :body)
  end
  
  def ensure_correct_employee
    @article = Article.find(params[:id])
    redirect_to article_path(@article) unless @article.created_by?(current_employee)
  end
  

end
