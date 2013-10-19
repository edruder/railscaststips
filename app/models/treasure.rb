class Treasure < ActiveRecord::Base
  
  # == Validations ==
  validates :description, presence: true
  validates_length_of :description, maximum: 150, allow_blank: false

  # == Associations ==
  belongs_to :railscast

  # == Tags ==
  acts_as_taggable
end
