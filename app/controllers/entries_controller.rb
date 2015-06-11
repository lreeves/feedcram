class EntriesController < ApplicationController
  def show
    @entry = FeedEntry.find(params[:id])
  end
end
