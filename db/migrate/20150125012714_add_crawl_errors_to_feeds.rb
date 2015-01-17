class AddCrawlErrorsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :crawl_errors, :integer, default: 0
  end
end
