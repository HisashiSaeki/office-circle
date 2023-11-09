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
    @posts = Post.where(is_published: true).incluedes(:employee, :tags)
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :employee_id, :is_published)
  end
  
end
