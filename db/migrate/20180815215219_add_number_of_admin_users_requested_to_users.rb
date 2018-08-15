class AddNumberOfAdminUsersRequestedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :number_of_admin_users_requested, :integer, limit: 1
  end
end
