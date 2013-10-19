class RailscastsUpdater
  def initialize(railscasts_array)
    @railscasts_array = railscasts_array
  end

  def update
    @railscasts_array.each do |railscast_hash|
      railscast_hash.slice!('url', 'name', 'description', 'pro', 'revised', 'duration', 'position', 'permalink')
      railscast_hash['url'].sub! /json$/, 'html'
      Railscast.where(railscast_hash.slice('url', 'name')).first_or_create railscast_hash
    end
  end
end
