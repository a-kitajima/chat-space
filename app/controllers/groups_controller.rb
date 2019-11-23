class GroupsController < ApplicationController
  before_action :move_to_sign_in
  
  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_name)
    if @group.save
      @group.update(group_users)
      flash[:notice] = "グループを作成しました"
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループを編集しました"
      redirect_to "/groups/#{@group.id}/messages"
    else
      render action: :edit
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, {user_ids: []})
    end

    def group_name
      params.require(:group).permit(:name)
    end

    def group_users
      params.require(:group).permit(user_ids: [])
    end

    def move_to_sign_in
      unless user_signed_in?
        flash[:alert] = "ログインまたは登録が必要です。"
        redirect_to new_user_session_path
      end
    end

end
