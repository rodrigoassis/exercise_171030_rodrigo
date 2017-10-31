FactoryBot.define do
  factory :group_event do
  end

  factory :filled_group_event, class: GroupEvent do
    name 'First event'
    description 'Description'
    start_date '2017-10-30'
    end_date '2017-10-31'
    location 'Rio de Janeiro'
  end
end
