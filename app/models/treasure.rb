class Treasure < ActiveRecord::Base
  
  # == Validations ==
  validates :description, :time, presence: true
  validates_length_of :description, maximum: 150, allow_blank: false

  # == Associations ==
  belongs_to :railscast

  # == Tags ==
  acts_as_taggable

  # == Methods ==
  def at_second
    time.min * 60 + time.sec
  end
end
