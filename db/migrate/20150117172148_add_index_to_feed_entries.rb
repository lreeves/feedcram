class AddIndexToFeedEntries < ActiveRecord::Migration[5.0]
  def change
    add_index :feed_entries, [:feed_id, :entry], unique: true
  end
end
