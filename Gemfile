source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
 
gem 'rails', '~> 5.1.1' 
gem 'puma', '~> 3.7' 
gem 'sass-rails', '~> 5.0' 
gem 'uglifier', '>= 1.3.0' 
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'   
gem 'bootstrap-sass' 
gem 'notifyjs_rails' 
gem 'rails-i18n'
gem 'jquery-rails'   
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '3.3.7'
  gem 'rails-assets-bootstrap.growl'
end
 

group :development, :test do 
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing' 
  gem 'mysql2', '>= 0.3.18', '< 0.5' 
end

group :development do 
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2' 
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  # Heroku
  gem 'pg' 
  gem 'rails_12factor'
end 
