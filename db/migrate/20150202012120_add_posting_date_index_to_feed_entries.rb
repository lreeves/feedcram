class AddPostingDateIndexToFeedEntries < ActiveRecord::Migration
  def change
    add_index :feed_entries, :posting_date
  end
end
