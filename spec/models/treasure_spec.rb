require 'spec_helper'

describe Treasure do
  it "should have a valid factory" do
    FactoryGirl.create(:treasure).should be_valid
  end
  
  it { should belong_to :railscast }
  it { should validate_presence_of :description }
  it { should validate_presence_of :time }

  it { should ensure_length_of(:description).is_at_most(150) }

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

end
