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
        error!('Unauthorised.', 401) if api_token_not_valid?
      end

      private

      def api_token_not_valid?
        api_token_is_nil? || invalid_api_token?
      end

      def api_token_is_nil?
        ENV['API_TOKEN'].nil?
      end

      def invalid_api_token?
        ENV['API_TOKEN'] != params[:api_token]
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
