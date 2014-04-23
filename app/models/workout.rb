# encoding: UTF-8
#
require 'user'

# Represents a workout in the database.
#
class Workout < ActiveRecord::Base
  belongs_to :user

  validates :active_duration, :distance, :duration,  presence: true
  validates :end_time, :start_time, :user, presence: true

  def date
    start_time.to_date
  end
end
