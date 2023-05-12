source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# Attach cloud and local files in Rails applications
gem 'activestorage', '~> 7.0', '>= 7.0.4.3'

# HTML, CSS, and JavaScript framework
gem 'bootstrap', '~> 5.2', '>= 5.2.3'

# Authentication solution for Rails with Warden
gem 'devise', '~> 4.9', '>= 4.9.2'

# Authorization for Rails applications
gem 'pundit', '~> 2.3'

# Rack framework for multiple-provider authentication
gem 'omniauth', '~> 2.1', '>= 2.1.1'

#  Login to Google
gem 'omniauth-google-oauth2', '~> 1.1', '>= 1.1.1'

# To prevent Cross-Site Request Forgery on the request phase
gem 'omniauth-rails_csrf_protection', '~> 1.0', '>= 1.0.1'

# Autoload dotenv in Rails
gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'

# Provides a framework and DSL for defining and using factories
gem 'factory_bot', '~> 6.2', '>= 6.2.1'

# Official AWS Ruby gem for Amazon Simple Storage Service (Amazon S3)
gem 'aws-sdk-s3'

# Manipulate images with minimal use of memory
gem 'mini_magick'

#  Background processing for Ruby
gem 'sidekiq', '~> 7.1'

# A Ruby client that tries to match Redis' API one-to-one
gem 'redis', '~> 5.0', '>= 5.0.6'

# For writing and deploying cron jobs
gem 'whenever', '~> 1.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Code style checking and code formatting tool
gem 'rubocop', '~> 1.50', '>= 1.50.2'

# Rails code style checking tool
gem 'rubocop-rails', '~> 2.19', '>= 2.19.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
