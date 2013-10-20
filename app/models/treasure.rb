class Treasure < ActiveRecord::Base
  
  # == Validations ==
  validates :description, :time, :railscast, presence: true
  validates :description, length: { maximum: 150 }
  validate :time_fits_duration

  # == Associations ==
  belongs_to :railscast, counter_cache: true
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

  # == Callbacks ==
  before_validation :normalize_time
  before_save :add_railscast_tag
  after_initialize :reset_time

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

  def self.most_voted
    by_votes.first
  end

  def self.most_recent
    self.order('created_at DESC').first
  end

  def self.most_tagged
    select("treasures.*, COUNT(tags.id) as number_of_tags").
    joins(:tags).
    group('treasures.id').
    order("number_of_tags DESC").first
  end

  def votes
    read_attribute(:votes) || treasure_votes.sum(:value)
  end

  private # =========================== PRIVATE ============================= #

  def time_fits_duration
    errors.add :time, 'is out of duration' if time and railscast and railscast.out_of_duration? time
  end

  def add_railscast_tag
    if self.railscast.present?
      self.tag_list << "#{self.railscast.position}"
    end
  end

  # 'Remove' date and hour.
  def normalize_time
    if time.present?
      Time::DATE_FORMATS[:ms] = "%M:%S"
      self.time = "0:#{time.to_formatted_s(:ms)}".to_time
    end
  end

  def reset_time
    self.time = "0:0:0".to_time unless time.present?
  end
end
