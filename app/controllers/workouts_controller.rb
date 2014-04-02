# encoding: UTF-8
#
# WorkoutsController provides the json API for creating and fetching
# workouts.
#
class WorkoutsController < ApplicationController
  respond_to :json

  def create
    @workout = Workout.new

    if @workout.save
      respond_with(@workout, status: :created)
    else
      respond_with(@workout, status: :unprocessable_entity)
    end
  end
end

# Simple Workout class used to build out the controller.
#
class Workout
  def to_json(lol)
    ''
  end

  def save
  end
end
