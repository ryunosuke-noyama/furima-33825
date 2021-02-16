FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { "111aaa" }
    password_confirmation { password } 

    transient do
      person { Gimei.name }
    end
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    birthday { Faker::Date.backward }
  end

end
