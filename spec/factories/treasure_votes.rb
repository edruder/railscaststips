# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :treasure_vote do
    value 1
    user nil
    treasure nil
  end
end
