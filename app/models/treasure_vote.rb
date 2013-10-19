class TreasureVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :treasure

  validates_uniqueness_of :treasure_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
end
