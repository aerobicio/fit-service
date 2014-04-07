# encoding: UTF-8
#
require 'grape'
require 'workout'

module Fit
  # ApiV1 defines version one of the fit-service API.
  #
  class ApiV1 < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      def authenticate!
        error!('Unauthorised.', 401) unless valid_api_token?
      end

      private

      def valid_api_token?
        server_side_token_set? && api_token_matches_server_side_token?
      end

      def server_side_token_set?
        !ENV['API_TOKEN'].nil?
      end

      def api_token_matches_server_side_token?
        ENV['API_TOKEN'] == params[:api_token]
      end
    end

    # global handler for simple not found case
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: e.message, status: 404)
    end

    desc 'Creates a workout from an uploaded FIT file'
    params do
      requires :device_id, type: String
      requires :device_workout_id, type: String
      requires :fit_file, type: String
      requires :member_id, type: Integer
    end
    post :workouts do
      authenticate!
    end

    desc 'Find a workout for a given id'
    params do
      requires :id, type: Integer
    end
    get 'workouts/:id' do
      authenticate!
      Workout.find(params[:id])
    end
  end
end
