class Public::CommentsController < ApplicationController
  before_action :ensure_correct_employee, only: [:destroy]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = current_employee.comments.new(comment_params)
    @comment.article_id = @article.id
    if @comment.save
      redirect_to article_path(@article)
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to article_path(params[:article_id])
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  def ensure_correct_employee
    @comment = Comment.find(params[:id])
    unless @comment.employee == current_employee
      redirect_to articles_path
    end
  end
  
end
