require 'spec_helper'

describe User do
  it { should have_many :treasure_votes }

  describe '#can_vote_for?' do
    before :each do
      @user = FactoryGirl.create :user
      railscast = FactoryGirl.create :railscast
      @treasure = FactoryGirl.create :treasure, railscast: railscast
    end

    it 'can vote' do
      @user.can_vote_for?(@treasure).should be_true
    end

    it 'can not vote' do
      FactoryGirl.create :treasure_vote, user: @user, treasure: @treasure
      @user.can_vote_for?(@treasure).should be_false
    end
  end
end
