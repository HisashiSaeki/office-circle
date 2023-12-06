class Admin::CommentsController < ApplicationController

  def destroy
    @article = Article.includes(comments: :employee).find(params[:article_id]) if Comment.find(params[:id]).destroy
  end

end
