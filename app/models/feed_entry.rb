class FeedEntry < ActiveRecord::Base
  before_create :set_default_time
  belongs_to :feed, counter_cache: true

  scope :unseen, ->(user_id) do
    where.not(id: Viewed.select(:feed_entry_id).where(user_id: user_id))
  end

  # For feeds without time information
  def set_default_time
    self.posting_date = Time.zone.now
  end
end
