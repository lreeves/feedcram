class FeedsController < ApplicationController
  def add
    current_user.subscribe_to_url(feed_params[:url])
    redirect_to :back
  end

  def export
    @feeds = current_user.feeds
  end

  def history
    @viewed = current_user.
      viewed.
      includes(:feed_entry, feed_entry: :feed).
      order(id: :desc).
      paginate(page: params[:page])
  end

  def index
    @feeds = current_user.feeds.paginate(page: params[:page])
  end

  def mark_all_read
    current_user.mark_all_read
    flash[:notice] = 'Marked everything as read!'
    redirect_to :back
  end

  def mark_as_read
    entry_ids = params[:entries].split(',')
    current_user.mark_entries_read(entry_ids)
    redirect_to :back
  end

  def read
    all_unread_entry_ids = current_user.unread_entry_ids

    @unread_count = all_unread_entry_ids.count
    @unread_entry_ids = all_unread_entry_ids.first(10)
    @entries = FeedEntry.
      where(id: @unread_entry_ids).
      order(posting_date: :desc).
      includes(:feed)
  end

  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.feed_entries.
      order(created_at: :desc).
      paginate(page: params[:page])
  end

  def unsubscribe
    feed = Feed.find(params[:id])
    UserSubscription.find_by(user: current_user, feed: feed).delete
    flash[:notice] = 'Unsubscribed from feed.'
    redirect_to :back
  end

  def update
    feed = Feed.find(params[:id])
    feed.crawl
    flash[:notice] = 'Feed updated.'
    redirect_to :back
  end

  private

  def feed_params
    params.permit(:url)
  end
end
