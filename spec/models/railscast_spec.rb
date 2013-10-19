require 'spec_helper'

describe Railscast do
  it { should validate_presence_of :url }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }

  describe 'parse_name_from_path' do
    it 'returns basename' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/index.html'
      railscast.parse_name_from_path.should == 'index'
    end
  end

  describe 'video_url' do
    it 'returns video url' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/index.html'
      railscast.video_url.should == 'http://media.railscasts.com/assets/episodes/videos/index.mp4'
    end
  end
end
