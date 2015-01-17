require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create!(password: 'xxx') }
  let!(:feed) { Feed.create!(url: 'url') }
  let!(:feed_entry1) { FeedEntry.create!(feed: feed, entry: 'x') }
  let!(:feed_entry2) { FeedEntry.create!(feed: feed, entry: 'y') }
  let!(:sub) { UserSubscription.create!(user: user, feed: feed) }

  describe '#unread_entries' do
    it 'returns items to read' do
      expect(user.unread_entries.size).to eq 2
    end

    context 'when an item is read' do
      before do
        Viewed.create!(user: user, feed_entry: feed_entry2)
      end

      it 'returns one item to read' do
        expect(user.unread_entries.size).to eq 1
      end
    end
  end
end
