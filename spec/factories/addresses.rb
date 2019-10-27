FactoryBot.define do

  factory  :address do
    firstname                  {"mercari"}
    lastname                   {"taro"}
    firstname_kana             {"mercari"}
    lastname_kana              {"taro"}
    postalcode                 {"1111111"}
    prefecture_id              {"1"}
    city_name                  {"city"}
    address_number             {"1"}
    building_name              {"mercari"}
    phone_number               {"11111111111"}
    
    association :user
  end
  
end



