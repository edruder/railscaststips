# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :railscast do
    sequence(:url) { |n| "http://railscasts.com/episodes/#{n}-fixture" }
    sequence(:name) { |n| "Fixture #{n}" }
    description "A description"
    sequence(:position) { |n| n }
    permalink 'fixture'
  end
end
