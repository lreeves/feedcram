class AddWebsiteToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :website, :string
  end
end
