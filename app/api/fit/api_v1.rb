# encoding: UTF-8
#
require 'grape'

module Fit
  # ApiV1 defines version one of the fit-service API.
  #
  class ApiV1 < Grape::API
    version 'v1', using: :path
    format :json

    desc 'Creates a workout from an uploaded FIT file'
    params do
      requires :device_id, type: String
      requires :device_workout_id, type: String
      requires :fit_file, type: String
      requires :member_id, type: Integer
    end
    post :workouts do
    end
  end
end
