require 'spec_helper'

describe RailscastsUpdater do
  describe ".update" do
    context "when all railscasts are new" do
      it "creates all railscasts" do
        Railscast.count.should == 0
        updater = RailscastsUpdater.new [
          {"url"=>"http://railscasts.com/episodes/3-find-through-association.json", "name"=>"Find Through Association", "position"=>3, "permalink"=>"find-through-association", "description"=>"No need to pass foreign keys in find conditions, just do the find through a has_many association.", "duration"=>"2:17", "pro"=>false, "revised"=>false},
          {"url"=>"http://railscasts.com/episodes/2-dynamic-find-by-methods.json", "name"=>"Dynamic find_by Methods", "position"=>2, "permalink"=>"dynamic-find-by-methods", "description"=>"Shorten simple finds considerably and improve readability by using the dynamic find_all_by and find_by methods.", "duration"=>"1:28", "pro" => false, "revised"=>false },
          {"url"=>"http://railscasts.com/episodes/1-caching-with-instance-variables.json", "name"=>"Caching with Instance Variables", "position"=>1, "permalink"=>"caching-with-instance-variables", "description"=>"Learn a quick way to improve performance. Just store the end result of an expensive command in an instance variable!", "duration"=>"2:06", "pro"=>false, "revised"=>false }
        ]
        updater.update
        Railscast.count.should == 3
      end
    end # context when all railscasts are new

    context "when not all railscast are new" do
      it "creates only the new railscasts" do
        FactoryGirl.create :railscast, url: 'http://railscasts.com/episodes/3-find-through-association.json', name: 'Find Through Association'
        Railscast.count.should == 1

        updater = RailscastsUpdater.new [
          {"url"=>"http://railscasts.com/episodes/3-find-through-association.json", "name"=>"Find Through Association", "position"=>3, "permalink"=>"find-through-association", "description"=>"No need to pass foreign keys in find conditions, just do the find through a has_many association.", "duration"=>"2:17", "pro"=>false, "revised"=>false},
          {"url"=>"http://railscasts.com/episodes/2-dynamic-find-by-methods.json", "name"=>"Dynamic find_by Methods", "position"=>2, "permalink"=>"dynamic-find-by-methods", "description"=>"Shorten simple finds considerably and improve readability by using the dynamic find_all_by and find_by methods.", "duration"=>"1:28", "pro" => false, "revised"=>false },
          {"url"=>"http://railscasts.com/episodes/1-caching-with-instance-variables.json", "name"=>"Caching with Instance Variables", "position"=>1, "permalink"=>"caching-with-instance-variables", "description"=>"Learn a quick way to improve performance. Just store the end result of an expensive command in an instance variable!", "duration"=>"2:06", "pro"=>false, "revised"=>false }
        ]
        updater.update
        Railscast.count.should == 3
      end
    end # context when not all railscast are new
  end # describe .update
end # describe RailscastsUpdater
