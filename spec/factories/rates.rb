FactoryGirl.define do
  factory :rate do
    from "EUR"
    to "RUR"
    ask 1.5
    bid 1.5
    parsed_at { Time.now }
  end
end
