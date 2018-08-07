class ChangeDefaultValueOfUserRoleToWorker < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :role, :integer, limit: 1, default: 1
  end
end
