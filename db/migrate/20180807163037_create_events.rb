class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :whatspp_message_id
      t.integer :category, limit: 1

      t.timestamps
    end
  end
end
