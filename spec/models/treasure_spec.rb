require 'spec_helper'

describe Treasure do
  it "should have a valid factory" do
    FactoryGirl.create(:treasure).should be_valid
  end
  
  it { should belong_to :railscast }
  it { should validate_presence_of :description }
  it { should validate_presence_of :time }
  it { should have_many :treasure_votes }

  it { should ensure_length_of(:description).is_at_most(150) }

  it "accepts the time if fits the railscast's duration" do
    railscast = FactoryGirl.create :railscast, duration: '0:12:32'
    treasure = FactoryGirl.build :treasure, time: '0:12:31', railscast: railscast
    treasure.should have(:no).error_on(:time)
  end

  it "does not accept the time if fits the railscast's duration" do
    railscast = FactoryGirl.create :railscast, duration: '0:12:32'
    treasure = FactoryGirl.build :treasure, time: '0:12:33', railscast: railscast
    treasure.should have(1).error_on(:time)
  end

  describe '#at_second' do
    it 'caluclates amount of seconds' do
      treasure = FactoryGirl.create :treasure, time: Time.parse('00:02:26')
      treasure.at_second.should == 146
    end
  end

  describe '.related_treasures' do
    before :each do
      railscast = FactoryGirl.create :railscast
      @treasure = FactoryGirl.create :treasure, railscast: railscast
      FactoryGirl.create :treasure, railscast: railscast
      @treasures = Treasure.related_treasures(@treasure).to_a
    end

    it 'returns one treasure' do
      @treasures.length.should == 1
    end

    it 'does not return the provided treasure' do
      @treasures.should_not include(@treasure)
    end
  end
  
  describe '.by_votes' do
    before :each do
      generate_treasures_with_votes
    end

    it 'returns tresures ordered by votes' do
      ordered_treasures = Treasure.by_votes
      ordered_treasures.should == [@t2, @t1, @t3]
    end

    it 'returns treasures with sum of votes' do
      ordered_treasures = Treasure.by_votes
      ordered_treasures[0].votes == 2
      ordered_treasures[1].votes == 1
      ordered_treasures[2].votes == 0
    end
  end

  describe '.most_voted' do
    before :each do
      generate_treasures_with_votes
    end

    it 'returns de most voted treasure' do
      Treasure.most_voted.should == @t2
    end
  end

  describe '.most_recent' do

    it 'returns the most recent treasure' do
      @user = FactoryGirl.create :user
      railscast = FactoryGirl.create :railscast
      @t1 = FactoryGirl.create :treasure, railscast: railscast, created_at: 3.days.ago 
      @t2 = FactoryGirl.create :treasure, railscast: railscast, created_at: 2.days.ago 
      @t3 = FactoryGirl.create :treasure, railscast: railscast, created_at: 1.day.ago
      Treasure.most_recent.should == @t3
    end

  end

  describe '.most_tagged' do
    before :each do
      @user = FactoryGirl.create :user
      railscast = FactoryGirl.create :railscast
      @t1 = FactoryGirl.create :treasure, railscast: railscast, tag_list: 'tag 2'
      @t2 = FactoryGirl.create :treasure, railscast: railscast, tag_list: 'tag 1, tag 2, tag 3'
      @t3 = FactoryGirl.create :treasure, railscast: railscast, tag_list: 'tag 1, tag 3'
    end

    it 'returns the most recent treasure' do
      Treasure.most_tagged.should == @t2
    end

  end

  describe '#votes' do
    before :each do
      generate_treasures_with_votes
    end

    it 'returns total votes' do
      @t1.votes.should == 1
      @t2.votes.should == 2
      @t3.votes.should == 0
    end
  end


  def generate_treasures_with_votes
    @user = FactoryGirl.create :user
    @user2 = FactoryGirl.create :user
    railscast = FactoryGirl.create :railscast
    @t1 = FactoryGirl.create :treasure, railscast: railscast
    @t2 = FactoryGirl.create :treasure, railscast: railscast
    @t3 = FactoryGirl.create :treasure, railscast: railscast
    FactoryGirl.create :treasure_vote, user: @user, treasure: @t2
    FactoryGirl.create :treasure_vote, user: @user2, treasure: @t2
    FactoryGirl.create :treasure_vote, user: @user, treasure: @t1
  end

end
