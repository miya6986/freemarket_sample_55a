FactoryBot.define do
  factory :product do
    name {"aaa"}
    description {"aaa"}
    size {"m"}
    condition {"aaa"}
    postage {"aaa"}
    shipping_method {"aaa"}
    prefecture_id {"1"}
    shipping_days {"aaa"}
    price {"3000"}
    buyer 
    seller 
    category 
    brand 
    # association :user 
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }

  end
end