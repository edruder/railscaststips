FactoryGirl.define do
  factory :treasure do
    sequence(:description) { |n| "Desciption of awesome feature I found on railscast number #{n}"}
  end
end
