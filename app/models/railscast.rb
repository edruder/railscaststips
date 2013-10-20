class Railscast < ActiveRecord::Base

  # == Constants ==
  VIDEO_BASE_URL = 'http://media.railscasts.com/assets/episodes/videos/'
  IMAGE_BASE_URL = 'http://railscasts.com/static/episodes/stills/'
  VIDEO_FORMATS = ['mp4', 'm4v', 'webm', 'ogv']

  # == Relations ==
  has_many :treasures

  # == Validations ==
  validates :url, :name, :description, :position, :permalink, presence: true
  validates :url, :name, uniqueness: true

  # == Methods ==

  def video_urls
    return [] if pro or revised
    VIDEO_FORMATS.collect { |vf| "#{ VIDEO_BASE_URL }#{ generate_basename }.#{ vf }" }
  end

  def image_url
    IMAGE_BASE_URL + generate_basename + '.png'
  end

  def parse_name_from_path
    File.basename url, '.*'
  end

  def generate_basename
    "#{formatted_position}-#{permalink}"
  end

  def complete_name
    "#{formatted_position} - #{name}"
  end

  def out_of_duration?(time)
    time.seconds_since_midnight > duration_in_seconds
  end

  private # ========================= PRIVATE =========================== #

  def formatted_position
    "%03d" % position
  end

  def duration_in_seconds
    "00:#{duration}".to_time.seconds_since_midnight
  end
end
