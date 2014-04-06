source 'https://rubygems.org'
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.11'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

gem 'activerecord-jdbcpostgresql-adapter', require: false
gem 'grape', require: false
gem 'trinidad', require: false

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2', require: false

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'rubocop'
end

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

group :console do
  gem 'gem_bench'
end
