FactoryBot.define do
  factory :user do
    email { "sakshi@gmail.com" }
    password { "123456" }
    restaurant {create(:restaurant )}
  end
end