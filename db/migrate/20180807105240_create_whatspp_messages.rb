class CreateWhatsppMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :whatspp_messages do |t|
      t.string :data
      t.integer :user_id
      t.boolean :spam, default: false

      t.timestamps
    end
  end
end
