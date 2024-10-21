FactoryBot.define do
  factory :comment do
    body { 'Nice comment' }
    association :post
    association :user
  end
end
