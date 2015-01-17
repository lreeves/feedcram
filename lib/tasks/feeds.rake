namespace :feeds do
  task :update => :environment do
    desc 'Update all feeds'
    Feed.all.each do |feed|
      puts "Crawling #{feed.url}"
      feed.crawl
    end
  end
end
