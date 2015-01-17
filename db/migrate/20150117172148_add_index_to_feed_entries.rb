class AddIndexToFeedEntries < ActiveRecord::Migration
  def change
    add_index :feed_entries, [:feed_id, :entry], unique: true
  end
end
