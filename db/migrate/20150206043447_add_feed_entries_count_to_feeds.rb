class AddFeedEntriesCountToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :feed_entries_count, :integer, default: 0
  end
end
