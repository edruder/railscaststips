class Treasure < ActiveRecord::Base
  
  # == Validations ==
  validates :description, :time, presence: true
  validates_length_of :description, maximum: 150, allow_blank: false

  # == Associations ==
  belongs_to :railscast

  # == Tags ==
  acts_as_taggable

  # == Full text Search ==
  include PgSearch
  pg_search_scope :text_search, against: :description,
    using: {tsearch: {dictionary: "english"}},
    associated_against: { tags: :name }

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

end
