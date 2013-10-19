json.array!(@treasures) do |treasure|
  json.extract! treasure, :description
  json.url treasure_url(treasure, format: :json)
end
