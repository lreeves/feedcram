class AccountController < ApplicationController
  def index
  end

  def upload
    opml_file = params[:opml]
    xml = Nokogiri::XML(opml_file.read)
    feeds = xml.xpath("//outline[@type='rss']")

    feeds.each do |feed|
      @user.subscribe_to_url(feed['xmlUrl'])
    end

    flash[:notice] = "Parsed #{feeds.length} feeds"
    redirect_to :back
  end
end
