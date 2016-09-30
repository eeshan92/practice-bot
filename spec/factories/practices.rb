FactoryGirl.define do
  now = DateTime.now

  factory :practice do
    date { now.to_date }
    start { now }
    status :active
    location
  end
end
