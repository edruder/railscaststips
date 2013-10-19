class Railscast < ActiveRecord::Base

  # == Constants ==
  VIDEO_BASE_URL = 'http://media.railscasts.com/assets/episodes/videos/'

  # == Relations ==
  has_many :treasures

  # == Validations ==
  validates :url, :name, :description, :position, :permalink, presence: true
  validates :url, :name, uniqueness: true

  # == Methods ==

  def video_url
    return '' if pro or revised
    VIDEO_BASE_URL + parse_name_from_path + '.mp4'
  end

  def parse_name_from_path
    File.basename url, '.*'
  end
end
