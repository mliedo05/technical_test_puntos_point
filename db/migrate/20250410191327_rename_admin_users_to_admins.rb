class RenameAdminUsersToAdmins < ActiveRecord::Migration[5.2]
  def change
    rename_table :admin_users, :admins
  end
end
