FactoryBot.define do

  factory :group do
    name              { Faker::Food.dish }
  end

end