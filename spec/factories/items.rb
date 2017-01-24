FactoryGirl.define do
  factory :item do
    name Faker::Name.title
    description Faker::Cat.name
    unit_price 1

    merchant
  end
end
