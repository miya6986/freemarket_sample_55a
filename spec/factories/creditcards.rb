FactoryBot.define do
  factory :creditcard do
    customer_id {"cus_eef04695bbc73eed14a7ece9c006"}
    association :user, factory: :user
  end
end