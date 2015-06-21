class Viewed < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  self.table_name = :viewed
end
