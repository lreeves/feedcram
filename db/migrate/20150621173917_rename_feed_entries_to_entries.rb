class RenameFeedEntriesToEntries < ActiveRecord::Migration[5.0]
  def change
    rename_table :feed_entries, :entries
  end
end
