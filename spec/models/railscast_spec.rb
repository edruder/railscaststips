require 'spec_helper'

describe Railscast do
  it { should validate_presence_of :url }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :position }
  it { should validate_presence_of :permalink }
  it { should validate_uniqueness_of :url }
  it { should validate_uniqueness_of :name }
  it { should have_many :treasures }

  describe '#parse_name_from_path' do
    it 'returns basename' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/123-index', position: '123', permalink: 'index'
      railscast.parse_name_from_path.should == '123-index'
    end
  end

  describe '#generate_basename' do
    it 'returns basename' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/123-index', position: '123', permalink: 'index'
      railscast.generate_basename.should == '123-index'
    end
  end

  describe '#video_urls' do
    it 'returns video url' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/123-index', position: '123', permalink: 'index'
      urls = railscast.video_urls
      urls[0].should == 'http://media.railscasts.com/assets/episodes/videos/123-index.mp4'
      urls[1].should == 'http://media.railscasts.com/assets/episodes/videos/123-index.m4v'
      urls[2].should == 'http://media.railscasts.com/assets/episodes/videos/123-index.webm'
      urls[3].should == 'http://media.railscasts.com/assets/episodes/videos/123-index.ogv'
    end
  end

  describe '#image_url' do
    it 'returns image url' do
      railscast = FactoryGirl.create :railscast, url: 'www.mysite.com/123-index', position: '123', permalink: 'index'
      railscast.image_url.should == 'http://railscasts.com/static/episodes/stills/123-index.png'
    end
  end

  describe "#out_of_duration?" do
    let(:railscast) { FactoryGirl.build :railscast, duration: '12:34' }
      
    it "returns true if time is after duration" do
      railscast.out_of_duration?('0:12:35'.to_time).should == true
    end

    it "returns true if time is before duration" do
      railscast.out_of_duration?('0:12:33'.to_time).should == false
    end
  end # describe #out_of_duration?
end
