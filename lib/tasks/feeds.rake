namespace :feeds do
  desc 'Update all feeds'
  task update: :environment do
    Feed.crawl_all
  end
end
