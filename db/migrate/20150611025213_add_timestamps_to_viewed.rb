class AddTimestampsToViewed < ActiveRecord::Migration
  def change
    add_column :viewed, :created_at, :datetime
    add_column :viewed, :updated_at, :datetime
  end
end
