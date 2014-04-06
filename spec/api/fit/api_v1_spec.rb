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
end
