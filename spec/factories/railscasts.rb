# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :railscast do
    url "http://railscasts.com/episodes/10-fixture"
    name "Fixture"
    description "A description"
    position 10
    permalink 'fixture'
  end
end
