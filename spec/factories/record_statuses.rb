## Read about factories at https://github.com/thoughtbot/factory_girl
#
FactoryGirl.define do

  factory :record_status do

    uuid

    trait :proposed do
      name "Proposed"
      description "TBD"
      uuid
    end

    trait :inReview do
      name "InReview"
      description "TBD"
      uuid
    end

    trait :draft do
      name "Draft"
      description "TBD"
      uuid
    end

    trait :defined do
      name "Defined"
      description "TBD"
      uuid
    end

    trait :retired do
      name "Retired"
      description "TBD"
      uuid
    end

    trait :custom do
      name "Custom"
      description "TBD"
      uuid
    end

    #factory :proposed_status, :traits => [:proposed]
    #factory :defined_status, :traits => [:defined]

    factory :proposed_status do
      proposed
    end

    factory :defined_status do
      defined
    end

    factory :inReview_status do
      inReview
    end

    factory :draft_status do
      draft
    end

    factory :retired_status do
      retired
    end

    factory :custom_status do
      custom
    end

  end
end
