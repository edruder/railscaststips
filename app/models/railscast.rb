class Railscast < ActiveRecord::Base

  # == Constants ==
  VIDEO_BASE_URL = 'http://media.railscasts.com/assets/episodes/videos/'
  IMAGE_BASE_URL = 'http://railscasts.com/static/episodes/stills/'

  # == Relations ==
  has_many :treasures

  # == Validations ==
  validates :url, :name, :description, :position, :permalink, presence: true
  validates :url, :name, uniqueness: true

  # == Methods ==

  def video_url
    return '' if pro or revised
    VIDEO_BASE_URL + generate_basename + '.mp4'
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

  private # ========================= PRIVATE =========================== #

  def formatted_position
    "%03d" % position
  end
end
