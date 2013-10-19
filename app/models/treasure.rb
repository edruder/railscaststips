class Treasure < ActiveRecord::Base
  
  # == Validations ==
  validates :description, :time, :railscast, presence: true
  validates_length_of :description, maximum: 150, allow_blank: false

  # == Associations ==
  belongs_to :railscast
  has_many :treasure_votes

  # == Scopes ==
  scope :related_treasures, -> (treasure) { where(railscast_id: treasure.railscast_id).where('treasures.id != ?', treasure.id) }

  # == Tags ==
  acts_as_taggable

  # == Full text Search ==
  include PgSearch
  pg_search_scope :text_search, against: :description,
    using: {tsearch: {dictionary: "english"}},
    associated_against: { tags: :name, railscast: [ :name, :description ] }

  # == Methods ==
  def at_second
    time.min * 60 + time.sec
  end

  def self.search query
    if query.present?
      text_search(query)
    else
      scoped
    end
  end

  def self.by_votes
    select('treasures.*, SUM(coalesce(value, 0)) as votes').
    joins('left join treasure_votes on treasure_id=treasures.id').
    group('treasures.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || treasure_votes.sum(:value)
  end

end
