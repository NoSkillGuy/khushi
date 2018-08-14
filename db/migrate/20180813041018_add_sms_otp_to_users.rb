class AddSmsOtpToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :sms_otp, :integer
  end
end
