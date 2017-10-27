class AddPostingDateIndexToFeedEntries < ActiveRecord::Migration[5.0]
  def change
    add_index :feed_entries, :posting_date
  end
end
