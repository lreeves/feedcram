class RenameFeedEntriesToEntries < ActiveRecord::Migration
  def change
    rename_table :feed_entries, :entries
  end
end
