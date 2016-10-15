FactoryGirl.define do
  now = DateTime.now

  factory :practice do
    date { now.to_date }
    start { 1.days.from_now }
    status :active
  end
end
