class Public::FavoritesController < ApplicationController
  before_action :set_article
  
  def create
    @favorite = current_employee.favorites.new(article_id: @article.id)
    @favorite.save
    redirect_back fallback_location: employee_path(current_employee)
  end
  
  def destroy
    @favorite = current_employee.favorites.find_by(article_id: @article.id)
    @favorite.destroy
    redirect_back fallback_location: employee_path(current_employee)
  end
  
  private
  
  def set_article
    @article = Article.find(params[:article_id])
  end
end
