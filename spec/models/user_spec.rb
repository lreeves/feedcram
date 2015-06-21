require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create!(password: 'xxx') }
  let!(:feed) { Feed.create!(url: 'url') }
  let!(:entry1) { Entry.create!(feed: feed, entry: 'x') }
  let!(:entry2) { Entry.create!(feed: feed, entry: 'y') }
  let!(:sub) { UserSubscription.create!(user: user, feed: feed) }

  describe '#mark_all_read' do
    it 'marks all entries as read' do
      user.mark_all_read
      expect(user.unread_entry_ids.count).to eq 0
    end
  end

  describe '#unread_entry_ids' do
    it 'returns two items to read' do
      expect(user.unread_entry_ids.size).to eq 2
    end

    context 'when there are unsubscribed feeds' do
      before do
        second_feed = Feed.create!(url: 'url2')
        Entry.create!(feed: second_feed, entry: 'x')
      end

      it 'returns two items to read' do
        expect(user.unread_entry_ids.size).to eq 2
      end
    end

    context 'when an item is read' do
      before do
        Viewed.create!(user: user, entry: entry2)
      end

      it 'returns one item to read' do
        expect(user.unread_entry_ids.size).to eq 1
      end
    end
  end
end
