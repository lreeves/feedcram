xml.opml(version: '1.0') do
  xml.head do
    xml.title 'Exported feeds from FeedCram'
  end
  xml.body do
    @feeds.each do |feed|
      xml.outline(type: 'rss',
                  text: feed.title,
                  title: feed.title,
                  xmlUrl: feed.url,
                  htmlUrl: feed.website)
    end
  end
end
