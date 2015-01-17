class Viewed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed_entry

  self.table_name = :viewed
end
