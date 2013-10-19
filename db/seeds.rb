# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Railscast.destroy_all
railscasts = Railscast.create!([
  { url: "http://railscasts.com/episodes/295-sharing-mustache-templates.html", name: "Sharing Mustache Templates", description: "Mustache is a simple, logic-less templating language which allows you to use the same template for both Ruby and JavaScript. See how to set it up with a custom template handler in this episode.", pro: true, revised: false },
  { url: "http://railscasts.com/episodes/368-miniprofiler.html", name: "MiniProfiler", description: "MiniProfiler allows you to see the speed of a request conveniently on the page. It also shows the SQL queries performed and allows you to profile a specific block of code.", pro: false, revised: false },
  { url: "http://railscasts.com/episodes/392-a-tour-of-state-machines.html", name: "A Tour of State Machines", description: "Here I show how three popular state machine gems can be used to clean up a list of boolean/datetime fields. I also show a custom solution which keeps track of the history of events.", pro: true, revised: false },
])
