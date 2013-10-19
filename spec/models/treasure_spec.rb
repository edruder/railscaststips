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

end
