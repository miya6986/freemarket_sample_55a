FactoryBot.define do

  factory  :user do
    nickname              {"mercari"}
    email                 {"mercari@mercari.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    firstname             {"mercari"}
    lastname              {"taro"}
    firstname_kana        {"taro"}
    lastname_kana         {"mercari"}
    birth_year            {"1999"}
    birth_month           {"12"}
    birth_day             {"13"}
    phone_number          {"99999999999"}
  end
  
end