# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

Railscast.destroy_all
updater = RailscastsLoader.new JSON.parse(open("http://railscasts.com/episodes.json").read)
updater.update

Treasure.destroy_all
Treasure.create! [
  { railscast_id: Railscast.where(name: 'Custom Rake Tasks').first.id,
    description: 'Pick a random register using "order rand()"',
    time: '0:3:30',
    tag_list: "database, order sql, #{Railscast.where(name: 'Custom Rake Tasks').first.position}" },
  { railscast_id: Railscast.where(name: 'Importing CSV and Excel').first.id,
    description: 'Create a hash from two arrays',
    time: '0:6:07',
    tag_list: "ruby, hash, #{Railscast.where(name: 'Importing CSV and Excel').first.position}" },
  { railscast_id: Railscast.where(name: 'Importing CSV and Excel').first.id,
    description: 'Add model capabilities to a poro',
    time: '0:9:33',
    tag_list: "activemodel, #{Railscast.where(name: 'Importing CSV and Excel').first.position}" },
  { railscast_id: Railscast.where(name: 'A Tour of State Machines').first.id,
    description: "Delegate to a method wich uses inquiry to provide question mark methods",
    time: '0:11:00',
    tag_list: "ruby, string, #{Railscast.where(name: 'A Tour of State Machines').first.position}" },
  { railscast_id: Railscast.where(name: 'A Tour of State Machines').first.id,
    description: "Use activerecord's merge to merge scopes from different models in a query",
    time: '0:11:47',
    tag_list: "activerecord, merge, #{Railscast.where(name: 'A Tour of State Machines').first.position}" },
  { railscast_id: Railscast.where(name: 'Sharing Mustache Templates').first.id,
    description: "Use fat arrow instead of skiny arrow to keep the scope of the class",
    time: '0:12:13',
    tag_list: "coffeescript, fat arrow, skiny arrow, class scope, #{Railscast.where(name: 'Sharing Mustache Templates').first.position}" },
]
