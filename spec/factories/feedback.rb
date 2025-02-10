FactoryBot.define do
  factory :feedback do
    name { "Sakshi" }
    email { "sakshi@gmail.com" }
    comments { "Good" }
    restaurant {create(:restaurant )}
  end
end