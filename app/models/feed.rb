class Feed < ActiveRecord::Base
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions
  has_many :feed_entries

  scope :with_subscribers, -> { joins(:user_subscriptions) }

  def crawl
    response = fetch

    if response.blank?
      update(crawl_errors: crawl_errors.to_i + 1)
      return
    else
      feed = parse(response)

      if feed.present?
        update(
          title: feed.title,
          website: feed.url)
        feed.entries.each { |entry| update_entry(entry) }
        Feed.reset_counters(id, :feed_entries)
      end
    end
  end

  def self.crawl_all
    Feed.with_subscribers.each do |feed|
      puts "Crawling #{feed.url}"
      feed.crawl
    end
  end

  def parse(response)
    begin
      feed = Feedjira::Feed.parse(response)
    rescue Feedjira::NoParserAvailable
      update(crawl_errors: crawl_errors.to_i + 1)
      nil
    end
  end

  def fetch
    begin
      response = Net::HTTP.get_response(URI(url))

      if [301, 302].include? response.code.to_i
        new_location = response.header['Location']
        response = Net::HTTP.get_response(URI(new_location))
        update(url: new_location)
      end

      response.body
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
