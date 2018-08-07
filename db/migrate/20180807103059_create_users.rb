class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.string :email
      t.integer :role, limit: 1

      t.timestamps
    end
  end
end
