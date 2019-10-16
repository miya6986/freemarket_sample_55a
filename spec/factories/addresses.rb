FactoryBot.define do

  factory  :address do
    address_firstname          {"mercari"}
    address_lastname           {"taro"}
    address_firstname_kana     {"mercari"}
    address_lastname_kana      {"taro"}
    postalcode                 {"1111111"}
    prefecture_id              {"1"}
    city_name                  {"city"}
    address_number             {"1"}
    building_name              {"mercari"}
    address_phone_number       {"11111111111"}
    
    association :user
  end
  
end



