# encoding: UTF-8
#
require 'spec_helper'

def login_with_basic_auth
  username = ENV['API_TOKEN']
  password = ''
  {
    'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic
    .encode_credentials(username, password)
  }
end

describe Fit::ApiV1 do
  describe 'POST /v1/workouts' do
    context 'with valid parameters' do
      before do
        member = FactoryGirl.create(:user)
        post '/v1/workouts', {
          device_id: 1,
          device_workout_id: 1,
          fit_file: uploaded_activity,
          member_id: member.id
          }, login_with_basic_auth
      end

      it 'should respond with HTTP 201 created' do
        response.status.should == 201
      end

      it 'should return a JSON representation of the newly created workout' do
        json = JSON.parse(response.body)

        json.include?('id').should be_true
        json.include?('active_duration').should be_true
        json.include?('duration').should be_true
        json.include?('distance').should be_true
        json.include?('start_time').should be_true
        json.include?('end_time').should be_true
        json.include?('uuid').should be_true
        json.include?('device_id').should be_true
        json.include?('device_workout_id').should be_true
        json.include?('user_id').should be_true
        json.include?('sport').should be_true
      end
    end

    context 'with no parameters' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        post '/v1/workouts', {}, login_with_basic_auth
      end

      it 'should respond with HTTP 400 bad request' do
        response.status.should == 400
      end

      it 'should return a missing device_id error' do
        errors.include?('device_id is missing').should be_true
      end

      it 'should return a missing device_wokrout_id error' do
        errors.include?('fit_file is missing').should be_true
      end

      it 'should return a missing fit_file error' do
        errors.include?('fit_file is missing').should be_true
      end

      it 'should return a missing member_id error' do
        errors.include?('member_id is missing').should be_true
      end
    end
  end

  describe 'GET /v1/workouts/:id' do
    context 'with a valid workout id' do
      before do
        workout = FactoryGirl.create(:workout)
        get "/v1/workouts/#{workout.id}", {}, login_with_basic_auth
      end

      it 'should respond with HTTP 200 ok' do
        response.status.should == 200
      end
    end

    context 'with an invalid workout id' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        get '/v1/workouts/foo', {}, login_with_basic_auth
      end

      it 'should respond with HTTP 400 bad request' do
        response.status.should == 400
      end

      it 'should return an invalid id error' do
        errors.include?('id is invalid').should be_true
      end
    end

    context 'with a valid workout id and no API token' do
      before do
        workout = FactoryGirl.create(:workout)
        get "/v1/workouts/#{workout.id}"
      end

      it 'should respond with HTTP 401 unauthorised' do
        response.status.should == 401
      end
    end

    context 'with a non existent workout id' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        get '/v1/workouts/100', {}, login_with_basic_auth
      end

      it 'should respond with HTTP 404 not found' do
        response.status.should == 404
      end

      it 'should return a workout not found error' do
        errors.include?("Couldn't find Workout with id=100").should be_true
      end
    end
  end
end
