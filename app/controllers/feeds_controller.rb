class FeedsController < ApplicationController
  def add
    @user.subscribe_to_url(feed_params[:url])
    redirect_to :back
  end

  def index
  end

  def read
    @unread_entry_ids = @user.unread_entry_ids
    @entries = FeedEntry
      .where(id: @unread_entry_ids.first(10))
      .order(posting_date: :desc)
      .includes(:feed)
  end

  def mark_as_read
    entry_ids = params[:entries].split(',')
    @user.mark_entries_read(entry_ids)
    redirect_to :back
  end

  def mark_all_read
    @user.mark_all_read
    flash[:notice] = 'Marked everything as read!'
    redirect_to :back
  end

  def unsubscribe
    feed = Feed.find(params[:id])
    UserSubscription.find_by(user: @user, feed: feed).delete
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
