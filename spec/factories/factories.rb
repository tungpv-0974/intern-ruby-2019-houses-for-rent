FactoryBot.define do
  factory :user do
    first_name {FFaker::Name.name}
    last_name {FFaker::Name.name}
    email {FFaker::Internet.email}
    password {"123456"}
  end
end
