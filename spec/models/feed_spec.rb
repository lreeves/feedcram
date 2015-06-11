require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe '#crawl' do
    context 'for invalid feeds' do
      context 'for empty responses' do
        let(:feed) { Feed.create(url: 'http://badurl') }
        it 'increments the error count' do
          expect(feed).to receive(:fetch).and_return('')
          feed.crawl
          expect(feed.crawl_errors).to eq 1
        end
      end

      context 'for HTML responses' do
        let(:feed) { Feed.create(url: 'http://badurl') }
        it 'increments the error count' do
          expect(feed).to receive(:fetch).and_return('<html><head><title>')
          feed.crawl
          expect(feed.crawl_errors).to eq 1
        end
      end
    end

    context 'for redirected feeds' do
      let(:feed) { Feed.create(url: source) }
      let(:source) { 'http://redirect_source' }
      let(:target) { 'http://redirect_target' }

      before do
        stub_request(:get, source).
          to_return(status: 301, body: nil, headers: { Location: target })
        stub_request(:get, target).
          to_return(status: 200, body: '')
      end

      it 'updates the URL to the target' do
        feed.crawl
        expect(feed.url).to eq target
      end
    end

    context 'for valid feeds' do
      feeds = {
        boingboing: 'http://feeds.boingboing.net/boingboing/iBag',
        tenderlove: 'http://tenderlovemaking.com/atom.xml',
        tmm1:       'http://tmm1.net/atom.xml'
      }

      feeds.each do |name, url|
        context "when parsing #{name}" do
          let(:feed) { Feed.create(url: url) }
          before do
            VCR.use_cassette(name, allow_playback_repeats: true) do
              feed.crawl
            end
          end

          it 'updates the feed properties' do
            expect(feed.title).to_not be_blank
            expect(feed.website).to_not be_blank
          end

          it 'creates the correct amount of feed entries' do
            expect(FeedEntry.all.count).to_not eq 0
          end

          it 'sets the URL for each feed entry' do
            FeedEntry.all.each do |entry|
              expect(entry.url).to_not be_blank
            end
          end

          it 'sets content for each feed entry' do
            FeedEntry.all.each do |entry|
              expect(entry.content).to_not be_blank
            end
          end
        end
      end
    end
  end

  describe '#crawl_all' do
    before do
      feed = Feed.create!(url: 'a')
      user = User.create!(email: 'x', password: 'xxx')
      UserSubscription.create!(feed: feed, user: user)
    end

    it 'crawls all feeds with subscriptions' do
      expect_any_instance_of(Feed).to receive(:crawl).and_return(nil)
      Feed.crawl_all
    end
  end
end
