class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.employee_id = current_employee.id
    # if @post.save(post_params)
      
  end
  
  def index
    @posts = Post.where(is_published: true).incluedes(:employee, :tags, :favorites, :post_coments)
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = PostComment.where(post_id: @post).includes(:employee)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.save(post_params)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.delete
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :employee_id, :is_published)
  end
  
end
