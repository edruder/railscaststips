FactoryGirl.define do
  factory :treasure do
    sequence(:description) { |n| "Description of awesome feature I found on railscast number #{n}"}
    time Time.parse('0:02:26')
    railscast
  end
end
