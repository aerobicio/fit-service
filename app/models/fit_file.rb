# encoding: UTF-8
#
require 'jfit'
require 'workout'

# FitFile represents an uploaded FIT file. It has a name and a stores the
# binary data blob uploaded by the user.
class FitFile < ActiveRecord::Base
  belongs_to :workout

  validates :binary_data, :name, presence: true
  validates :workout_id, uniqueness: true

  def active_duration
    fit.session.total_timer_time
  end

  def distance
    fit.session.total_distance
  end

  def duration
    fit.session.total_elapsed_time
  end

  def end_time
    Time.zone.at(fit.session.timestamp) if fit.session.timestamp
  end

  def start_time
    Time.zone.at(fit.session.start_time) if fit.session.start_time
  end

  private

  def fit
    @fit ||= begin
               Jfit::File.read(StringIO.new(binary_data))
             rescue EOFError
               NullFitFile.new
             end
  end

  # A null representation of a Fit::File that is substituted when a Fit::File
  # cannot be processed.
  #
  class NullFitFile
    attr_reader :active_duration, :distance, :duration, :start_time, :end_time
  end
end
