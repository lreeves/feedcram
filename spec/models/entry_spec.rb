require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe '#new' do
    context 'when a feed is missing timestamps' do
      let(:feed) { Feed.create(url: 'http://antirez.com/rss') }

      before do
        VCR.use_cassette(:antirez, allow_playback_repeats: true) do
          feed.crawl
        end
      end

      it 'populates the posting date' do
        expect(feed.entries.first.posting_date).to_not eq nil
      end
    end
  end
end
