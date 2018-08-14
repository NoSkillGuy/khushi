class AddVerifiedPhoneNumberToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :verified_phone_number, :boolean, default: false
  end
end
