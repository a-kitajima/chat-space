class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.update(group_users)
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

    def group_users
      params.require(:group).permit(user_ids: [])
    end

end
