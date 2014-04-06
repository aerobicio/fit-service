# encoding: UTF-8
#
require 'load_paths'
require 'active_record_helper'
require 'user'

describe User do
  let(:user) { described_class.new }

  it { should validate_presence_of(:name) }
end
