FactoryGirl.define do
  factory :rate do
    from "EUR"
    to "RUR"
    ask 1.5
    bid 1.5
    parsed_at "2015-09-14 06:55:53"
  end
end
