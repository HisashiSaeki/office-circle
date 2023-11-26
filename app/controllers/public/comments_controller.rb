class Public::CommentsController < ApplicationController
  before_action :ensure_correct_employee, only: [:destroy]
  before_action :set_comments
  
  def create
    @comment = current_employee.comments.new(comment_params)
    @comment.article_id = @article.id
    @comment.save
  end
  
  def destroy
    @comment.destroy
  end
  
  
  private
  
  
  def comment_params 
    params.require(:comment).permit(:comment)
  end
  
  def ensure_correct_employee
    @comment = Comment.find(params[:id])
    redirect_to articles_path unless @comment.employee == current_employee || admin_signed_in?
  end
  
  def set_comments
    @article = Article.find(params[:article_id])
    @comments = Comment.where(article_id: @article).includes(:employee)
  end
  
end
