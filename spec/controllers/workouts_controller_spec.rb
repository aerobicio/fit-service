# encoding: UTF-8
#
require 'spec_helper'

describe WorkoutsController do
  describe 'create action' do
    before do
      Workout.should_receive(:new) { workout }

      get :create, fit_file: 'file', format: :json
    end

    context 'when successful' do
      let(:workout) { double(:workout, save: true) }

      it { should respond_with(:created) }
    end

    context 'when unsucessful' do
      let(:workout) { double(:workout, save: false) }

      it { should respond_with(:unprocessable_entity) }
    end
  end
end
