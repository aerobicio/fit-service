# encoding: UTF-8
#
require 'spec_helper'

describe Fit::ApiV1 do
  describe 'POST /v1/workouts' do
    context 'with no parameters' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        post '/v1/workouts'
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
        get "/v1/workouts/#{workout.id}"
      end

      it 'should respond with HTTP 200 ok' do
        response.status.should == 200
      end
    end

    context 'with an invalid workout id' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        get '/v1/workouts/foo'
      end

      it 'should respond with HTTP 400 bad request' do
        response.status.should == 400
      end

      it 'should return an invalid id error' do
        errors.include?('id is invalid').should be_true
      end
    end

    context 'with a non existent workout id' do
      let(:errors) { JSON.parse(response.body)['error'] }

      before do
        get '/v1/workouts/100'
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
