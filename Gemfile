source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.4'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'rails-i18n'
gem 'i18n-tasks'
gem 'searchkick'
gem 'kaminari'
gem 'carrierwave'
gem 'mini_magick', '~> 4.8'
gem 'draper', '~> 3.0', '>= 3.0.1'
gem 'slim', '~> 3.0', '>= 3.0.9'
gem 'slim-rails', '~> 3.1', '>= 3.1.3'
gem 'cancancan', '~> 2.1', '>= 2.1.3'
gem 'friendly_id', '~> 5.2', '>= 5.2.3'
gem 'redis'
gem 'twitter-text', '~> 2.1'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end
