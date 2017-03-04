ruby '2.3.3'

source 'https://rubygems.org'

gem 'rails', '4.2.7.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise'
gem 'kaminari' # Gem for pagination

# Gems for image uploading and processing
gem 'rmagick'
gem 'carrierwave'
##

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

if ENV['HEROKU']
  gem 'rails_12factor'
  gem 'pg'
else
  gem 'mysql2', group: :production
end
