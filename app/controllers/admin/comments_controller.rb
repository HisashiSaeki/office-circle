class Admin::CommentsController < ApplicationController
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @article = Article.find(params[:article_id])
    @comments = Comment.where(article_id: @article).includes(:employee)
  end
  
end
