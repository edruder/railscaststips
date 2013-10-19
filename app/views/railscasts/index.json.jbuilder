json.array!(@railscasts) do |railscast|
  json.extract! railscast, :url, :name, :description
  json.url railscast_url(railscast, format: :json)
end
