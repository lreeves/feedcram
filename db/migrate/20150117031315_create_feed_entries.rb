class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.integer :feed_id
      t.string :title
      t.binary :content
      t.timestamp :posting_date
      t.timestamps
    end
  end
end
