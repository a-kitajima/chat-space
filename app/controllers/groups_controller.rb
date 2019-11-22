class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    group = Group.create(group_params)
    group.update(group_users)
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
