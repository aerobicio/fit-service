# encoding: UTF-8
#
# User is an ActiveRecord model that represents
# a user in our system.
#
class User < ActiveRecord::Base
  validates :name, presence: true
end
