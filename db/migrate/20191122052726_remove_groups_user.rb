class RemoveGroupsUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups_users, :user_id, :integer
    remove_column :groups_users, :group_id, :integer
  end
end
