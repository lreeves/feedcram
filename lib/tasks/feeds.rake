namespace :feeds do
  desc 'Update all feeds'
  task :update => :environment do
    Feed.all.each do |feed|
      puts "Crawling #{feed.url}"
      feed.crawl
    end
  end
end
