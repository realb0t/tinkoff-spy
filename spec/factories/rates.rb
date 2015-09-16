FactoryGirl.define do
  factory :rate do
    from "EUR"
    to "RUR"
    ask { rand(0.01..1.0) }
    bid { rand(0.01..1.0) }
    parsed_at { Time.now }
  end
end
