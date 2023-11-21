class Public::NoticesController < ApplicationController
  before_action :ensure_correct_creater, only: [:new, :create, :destroy]
  before_action :set_notice, only: [:show, :destroy]
  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.group_id = @group.id
    if @notice.save
      redirect_to group_path(@group), notice: "お知らせを作成しました"
    else
      render :new
    end
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
    unless @group.is_created_by?(current_employee)
      redirect_to group_path(@group)
    end
  end

  def set_notice
    @notice = Notice.find(params[:id])
  end

end
