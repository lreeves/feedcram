class Feed < ActiveRecord::Base
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions
  has_many :feed_entries

  def crawl
    response = fetch

    if response.blank?
      update(crawl_errors: crawl_errors.to_i + 1)
      return
    else
      begin
        feed = Feedjira::Feed.parse(response)
      rescue Feedjira::NoParserAvailable
        update(crawl_errors: crawl_errors.to_i + 1)
        return
      end

      update(
        title: feed.title,
        website: feed.url)
      feed.entries.each { |entry| update_entry(entry) }
    end
  end

  def fetch
    begin
      Net::HTTP.get(URI(url))
    rescue
      ""
    end
  end

  def update_entry(raw_entry)
    entry = FeedEntry.find_or_create_by(
      feed: self,
      entry: raw_entry.entry_id)

    # Use the full content if available
    content = raw_entry.content
    content ||= raw_entry.summary

    entry.update(
      posting_date: raw_entry.published,
      content: content,
      title: raw_entry.title,
      url: raw_entry.url)
  end
end
