FactoryBot.define do

  factory  :buyer, class: User do
    nickname                  {"mercari"}
    sequence(:email)          {Faker::Internet.email}
    password                  {"00000000"}
    password_confirmation     {"00000000"}
    firstname                 {"mercari"}
    lastname                  {"taro"}
    firstname_kana            {"taro"}
    lastname_kana             {"mercari"}
    birth_year                {"1999"}
    birth_month               {"12"}
    birth_day                 {"13"}
    sequence(:phone_number)   {Faker::PhoneNumber.phone_number}

  end

  factory  :seller, class: User do
    nickname                  {"mercari"}
    sequence(:email)          {Faker::Internet.email}
    password                  {"00000000"}
    password_confirmation     {"00000000"}
    firstname                 {"mercari"}
    lastname                  {"taro"}
    firstname_kana            {"taro"}
    lastname_kana             {"mercari"}
    birth_year                {"1999"}
    birth_month               {"12"}
    birth_day                 {"13"}
    sequence(:phone_number)   {Faker::PhoneNumber.phone_number}

  end

  factory  :user do
    nickname                  {"mercari"}
    sequence(:email)          {Faker::Internet.email}
    password                  {"00000000"}
    password_confirmation     {"00000000"}
    firstname                 {"mercari"}
    lastname                  {"taro"}
    firstname_kana            {"taro"}
    lastname_kana             {"mercari"}
    birth_year                {"1999"}
    birth_month               {"12"}
    birth_day                 {"13"}
    sequence(:phone_number)   {Faker::PhoneNumber.phone_number}

  end

end 