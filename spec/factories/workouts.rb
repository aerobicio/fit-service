# encoding: UTF-8
#
FactoryGirl.define do
  factory :workout do
    user
    active_duration 1
    duration 1
    distance 1
    start_time '2013-07-19 14:42:45'
    end_time '2013-07-19 14:42:45'
  end
end
