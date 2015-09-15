FactoryGirl.define do
  factory :alert do
    currency "USD"
    deal_type "sell"
    sign "more"
    value 1.5
    email "mail@example.com"
  end

end
