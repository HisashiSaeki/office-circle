class Public::NoticesController < ApplicationController
  before_action :ensure_correct_creater, only: [:new, :create, :destroy]
  before_action :set_notice, only: [:show, :destroy]
  
  def new
    @notice = Notice.new
  end

  def create
    @notice = @group.notices.new(notice_params)
    @notice.save ? (redirect_to group_notice_path(@group, @notice), notice: "お知らせを作成しました") : (render :new)
  end

  def show
  end

  def destroy
    @notice.destroy
    redirect_to group_path(@group), notice: "お知らせを削除しました"
  end


  private
  

  def notice_params 
    params.require(:notice).permit(:title, :body)
  end

  def ensure_correct_creater
    @group = Group.find(params[:group_id])
    redirect_to group_path(@group) unless @group.created_by?(current_employee)
  end

  def set_notice
    @notice = Notice.find(params[:id])
  end

end
