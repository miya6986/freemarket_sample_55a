FactoryBot.define do
  factory :category do
    name          {Faker::Name.name}
    ancestry      {Faker::Number.within(range: 1..1000)}
  end
end  