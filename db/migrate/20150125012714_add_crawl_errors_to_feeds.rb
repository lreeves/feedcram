class AddCrawlErrorsToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :crawl_errors, :integer, default: 0
  end
end
