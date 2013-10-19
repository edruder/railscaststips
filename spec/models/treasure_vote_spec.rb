require 'spec_helper'

describe TreasureVote do
  it { should belong_to :user }
  it { should belong_to :treasure }
  it { should validate_presence_of :treasure }
  it { should validate_uniqueness_of :treasure_id }
  it { should ensure_inclusion_of(:value).in_array([1, -1]) }
end
