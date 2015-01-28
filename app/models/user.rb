class User < ActiveRecord::Base
  has_secure_password

  has_many :user_subscriptions
  has_many :viewed
  has_many :feeds, through: :user_subscriptions
  has_many :feed_entries, through: :feeds

  def unread_entry_ids
    all = feed_entries.select('id', 'posting_date').to_a

    seen = viewed.pluck(:feed_entry_id)
    unseen = all.reject { |e| seen.include? e.id }
    unseen.sort_by! { |entry| entry.posting_date.to_i }.reverse!

    unseen.map(&:id)
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
