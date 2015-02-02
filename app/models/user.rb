class User < ActiveRecord::Base
  has_secure_password

  has_many :user_subscriptions
  has_many :viewed
  has_many :feeds, through: :user_subscriptions
  has_many :feed_entries, through: :feeds

  def mark_all_read
    mark_entries_read(unread_entry_ids)
  end

  def unread_entry_ids
    all = feed_entries.select('id', 'posting_date')
      .where.not(id: Viewed.select(:feed_entry_id).where(user_id: id))
      .pluck(:id)
  end

  def mark_entries_read(entry_ids)
    entry_ids.each do |entry_id|
      Viewed.create(user: self, feed_entry_id: entry_id)
    end
  end

  def subscribe_to_url(url)
    feed = Feed.find_or_create_by(url: url)
    UserSubscription.find_or_create_by(user: self, feed: feed)
  end
end
