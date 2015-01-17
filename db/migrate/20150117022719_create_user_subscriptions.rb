class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|
      t.integer :user_id
      t.integer :feed_id
      t.timestamps
    end

    add_index :user_subscriptions, [:user_id, :feed_id], unique: true
  end
end
