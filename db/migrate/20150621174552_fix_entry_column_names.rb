class FixEntryColumnNames < ActiveRecord::Migration
  def change
    rename_column :feeds, :feed_entries_count, :entries_count
    rename_column :viewed, :feed_entry_id, :entry_id
  end
end
