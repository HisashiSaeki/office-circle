class Admin::ArticlesController < ApplicationController
  
  def index
    @articles = Article.is_published_articles.order(created_at: "DESC").page(params[:page])
    @tags = Tag.is_published_article_tags
  end

  def show
    @article = Article.find(params[:id])
    redirect_to articles_path if !@article.is_published && admin_signed_in?
    @comments = Comment.where(article_id: @article).includes(:employee)
    @comment = Comment.new
  end
  
end
