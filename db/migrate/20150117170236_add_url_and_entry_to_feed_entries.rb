class AddUrlAndEntryToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :entry, :string
    add_column :feed_entries, :url, :string
  end
end
