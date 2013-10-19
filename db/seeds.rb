# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

Railscast.destroy_all
result = JSON.parse(open("http://railscasts.com/episodes.json").read)
result.each do |r|
  r.slice!('url', 'name', 'description', 'pro', 'revised')
  r['url'].sub /json$/, 'html'
  Railscast.create! r
end
