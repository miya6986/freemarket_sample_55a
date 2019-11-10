FactoryBot.define do

  factory  :address do
    id                         {"99"}
    firstname                  {"mercari"}
    lastname                   {"taro"}
    firstname_kana             {"mercari"}
    lastname_kana              {"taro"}
    postalcode                 {"1111111"}
    prefecture_id              {"1"}
    city_name                  {"city"}
    address_number             {"1"}
    building_name              {"mercari"}
    phone_number               {"07011111111"}
    
    association :user
  end
  
end



