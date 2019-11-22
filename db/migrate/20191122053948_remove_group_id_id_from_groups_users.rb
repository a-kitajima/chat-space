class RemoveGroupIdIdFromGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups_users, :group_id_id, :integer
  end
end
