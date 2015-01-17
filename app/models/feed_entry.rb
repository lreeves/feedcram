class FeedEntry < ActiveRecord::Base
  before_create :set_default_time
  belongs_to :feed

  # For feeds without time information
  def set_default_time
    self.posting_date = Time.now
  end
end
