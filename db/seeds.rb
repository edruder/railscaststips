# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

Railscast.destroy_all
updater = RailscastsUpdater.new JSON.parse(open("http://railscasts.com/episodes.json").read)
updater.update

Treasure.destroy_all
Treasure.create! [
  { railscast_id: Railscast.where(name: 'Custom Rake Tasks').first.id, description: 'pick a random register using "order rand()"', time: '0:3:30' },
  { railscast_id: Railscast.where(name: 'Importing CSV and Excel').first.id, description: 'create a hash from two arrays', time: '0:6:07' },
  { railscast_id: Railscast.where(name: 'Importing CSV and Excel').first.id, description: 'add model capabilities to a poro', time: '0:9:33' },
  { railscast_id: Railscast.where(name: 'A Tour of State Machines').first.id, description: "delegate to a method wich uses inquiry to provide question mark methods", time: '0:11:00' },
  { railscast_id: Railscast.where(name: 'A Tour of State Machines').first.id, description: "use activerecord's merge to merge scopes from different models in a query", time: '0:11:47' },
]
