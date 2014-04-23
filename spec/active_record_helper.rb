# encoding: UTF-8
#
unless defined?(ActiveRecord)
  require 'activerecord-jdbcpostgresql-adapter'
  require 'active_record'
  require 'factory_girl'
  require 'shoulda-matchers'

  require 'factories/workouts'
  require 'factories/users'

  dbconfig = YAML.load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(dbconfig['test'])

  RSpec.configure do |config|
    config.around do |example|
      ActiveRecord::Base.transaction do
        example.run
        fail ActiveRecord::Rollback
      end
    end
  end
end
