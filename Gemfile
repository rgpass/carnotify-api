source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Allows for respond_to :json to work
gem 'responders', '~> 2.0'

gem 'httparty'

gem 'bcrypt-ruby', '3.1.2'

group :development do
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry'
end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem 'faker'
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor'
end