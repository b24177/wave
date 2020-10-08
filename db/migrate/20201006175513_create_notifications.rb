class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :post_id
      t.datetime :read_at

      t.timestamps
    end
  end
end
