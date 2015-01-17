class RemoveFeedFromViewed < ActiveRecord::Migration
  def change
    remove_index :viewed, [:user_id, :feed_id, :feed_entry_id]
    remove_column :viewed, :feed_id
    add_index :viewed, [:user_id, :feed_entry_id], unique: true
  end
end
