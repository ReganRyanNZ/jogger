FactoryGirl.define do
  factory :jog do
    time { rand(1000) }
    distance { rand(1000) }
    date Time.now
  end
end