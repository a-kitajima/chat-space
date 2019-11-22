class AddUserIdToGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups_users, :group, foreign_key: true
    add_reference :groups_users, :user, foreign_key: true
  end
end
