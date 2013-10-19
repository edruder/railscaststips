namespace :railscasts do
  desc "Update the railscasts"
  task :update => :environment do
    require 'open-uri'
    updater = RailscastsUpdater.new JSON.parse(open("http://railscasts.com/episodes.json").read)
    updater.update
  end
end
