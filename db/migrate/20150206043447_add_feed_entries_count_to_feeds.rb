class AddFeedEntriesCountToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :feed_entries_count, :integer, default: 0
  end
end
